var fallingSquares = function(positions) {
    // 1. Coordinate Compression
    const coordsSet = new Set();
    for (const [left, side] of positions) {
        coordsSet.add(left);
        coordsSet.add(left + side);
    }

    const coords = Array.from(coordsSet).sort((a, b) => a - b);
    const coordToIdx = new Map();
    for (let i = 0; i < coords.length; i++) {
        coordToIdx.set(coords[i], i);
    }

    // The segment tree will operate on indices corresponding to elementary intervals.
    // If coords has K unique points, there are K-1 elementary intervals.
    // E.g., coords = [c0, c1, c2], intervals are [c0,c1), [c1,c2). These correspond to indices 0, 1.
    // So, if coords.length is K, the max index for elementary intervals is K-2.
    const maxSegmentIdx = coords.length - 2;

    // Segment Tree Implementation
    // tree[nodeIdx] stores the maximum height in the range represented by nodeIdx
    // lazy[nodeIdx] stores a pending update value for the range represented by nodeIdx.
    // If lazy[nodeIdx] > 0, it means all elementary intervals in this node's range
    // should have a height of AT LEAST lazy[nodeIdx].
    const tree = new Array(4 * (maxSegmentIdx + 1)).fill(0);
    const lazy = new Array(4 * (maxSegmentIdx + 1)).fill(0);

    // Function to push down lazy updates to children
    function pushDown(nodeIdx, start, end) {
        if (lazy[nodeIdx] === 0) {
            return;
        }

        if (start !== end) { // Not a leaf node
            // Propagate lazy value to children
            tree[2 * nodeIdx] = Math.max(tree[2 * nodeIdx], lazy[nodeIdx]);
            lazy[2 * nodeIdx] = Math.max(lazy[2 * nodeIdx], lazy[nodeIdx]);

            tree[2 * nodeIdx + 1] = Math.max(tree[2 * nodeIdx + 1], lazy[nodeIdx]);
            lazy[2 * nodeIdx + 1] = Math.max(lazy[2 * nodeIdx + 1], lazy[nodeIdx]);
        }
        lazy[nodeIdx] = 0; // Clear lazy tag
    }

    // Function to query max height in a given range [queryL, queryR] (inclusive segment tree indices)
    function query(nodeIdx, start, end, queryL, queryR) {
        // If current segment range is outside query range, return 0 (no height contribution)
        if (start > end || start > queryR || end < queryL) {
            return 0;
        }

        // If current segment range is completely within query range, return its stored value
        if (queryL <= start && end <= queryR) {
            return tree[nodeIdx];
        }

        // Push down lazy updates before querying children
        pushDown(nodeIdx, start, end);

        // Recurse on children
        const mid = Math.floor((start + end) / 2);
        const leftMax = query(2 * nodeIdx, start, mid, queryL, queryR);
        const rightMax = query(2 * nodeIdx + 1, mid + 1, end, queryL, queryR);

        return Math.max(leftMax, rightMax);
    }

    // Function to update height in a given range [updateL, updateR] (inclusive segment tree indices) to 'val'
    function update(nodeIdx, start, end, updateL, updateR, val) {
        // If current segment range is outside update range, do nothing
        if (start > end || start > updateR || end < updateL) {
            return;
        }

        // If current segment range is completely within update range
        if (updateL <= start && end <= updateR) {
            tree[nodeIdx] = Math.max(tree[nodeIdx], val);
            lazy[nodeIdx] = Math.max(lazy[nodeIdx], val);
            return;
        }

        // Push down lazy updates before updating children
        pushDown(nodeIdx, start, end);

        // Recurse on children
        const mid = Math.floor((start + end) / 2);
        update(2 * nodeIdx, start, mid, updateL, updateR, val);
        update(2 * nodeIdx + 1, mid + 1, end, updateL, updateR, val);

        // Update current node's value based on children's values (after children might have been updated)
        tree[nodeIdx] = Math.max(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
    }

    const ans = [];
    let currentMaxOverallHeight = 0;

    // Handle edge case where there's only one coordinate (e.g., [1,1] and no other squares)
    // In this case, maxSegmentIdx would be -1, meaning no elementary intervals.
    // The loop below will handle it by not calling query/update if maxSegmentIdx < 0.
    // For a single square, the max height is just its side length.
    if (maxSegmentIdx < 0) {
        for (const [_, side] of positions) {
            currentMaxOverallHeight = Math.max(currentMaxOverallHeight, side);
            ans.push(currentMaxOverallHeight);
        }
        return ans;
    }

    for (const [left, side] of positions) {
        const right = left + side;
        // Convert actual coordinates to compressed segment tree indices
        const queryL = coordToIdx.get(left);
        const queryR = coordToIdx.get(right) - 1; // Exclusive right boundary, so we cover up to the index before 'right'

        // Find the maximum height in the current square's horizontal span
        const maxHeightInSpan = query(1, 0, maxSegmentIdx, queryL, queryR);

        // The new square lands on top of this max height
        const newSquareTopHeight = maxHeightInSpan + side;

        // Update the segment tree for the current square's span with its new top height
        update(1, 0, maxSegmentIdx, queryL, queryR, newSquareTopHeight);

        // Update the overall maximum height seen so far
        currentMaxOverallHeight = Math.max(currentMaxOverallHeight, newSquareTopHeight);
        ans.push(currentMaxOverallHeight);
    }

    return ans;
};