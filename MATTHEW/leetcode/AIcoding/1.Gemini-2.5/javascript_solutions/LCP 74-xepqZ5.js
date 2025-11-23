var strongestBlessingField = function(rectangles, queries) {
    // Step 1: Coordinate compression for y-coordinates
    const yValues = new Set();
    for (const [x, y, w, h] of rectangles) {
        yValues.add(y);
        yValues.add(y + h); // Inclusive end
    }
    for (const [x, y, w, h] of queries) {
        yValues.add(y);
        yValues.add(y + h); // Inclusive end
    }

    const yCoords = Array.from(yValues).sort((a, b) => a - b);
    const yMap = new Map();
    for (let i = 0; i < yCoords.length; i++) {
        yMap.set(yCoords[i], i);
    }

    // The segment tree will operate on intervals defined by adjacent yCoords.
    // Each segment tree leaf node `i` corresponds to the interval [yCoords[i], yCoords[i+1]-1].
    // So, there are `yCoords.length - 1` such segments.
    const numSegments = yCoords.length - 1;

    // If there's only one unique y-coordinate, numSegments will be 0.
    // In this case, no y-intervals exist, and all blessing forces are 0.
    if (numSegments === 0) {
        return new Array(queries.length).fill(0);
    }

    // Segment Tree implementation
    // Each node stores { max_val, lazy }
    // max_val: maximum blessing force in the node's range
    // lazy: pending increment/decrement to apply to children
    const tree = new Array(4 * numSegments).fill(null).map(() => ({ max_val: 0, lazy: 0 }));

    function pushDown(nodeIdx) {
        if (tree[nodeIdx].lazy !== 0) {
            const lazyVal = tree[nodeIdx].lazy;

            // Apply to left child
            tree[2 * nodeIdx].max_val += lazyVal;
            tree[2 * nodeIdx].lazy += lazyVal;

            // Apply to right child
            tree[2 * nodeIdx + 1].max_val += lazyVal;
            tree[2 * nodeIdx + 1].lazy += lazyVal;

            tree[nodeIdx].lazy = 0;
        }
    }

    function update(nodeIdx, segRangeStart, segRangeEnd, updateStart, updateEnd, delta) {
        // No overlap
        if (updateStart > segRangeEnd || updateEnd < segRangeStart) {
            return;
        }

        // Full overlap
        if (updateStart <= segRangeStart && segRangeEnd <= updateEnd) {
            tree[nodeIdx].max_val += delta;
            tree[nodeIdx].lazy += delta;
            return;
        }

        // Partial overlap
        pushDown(nodeIdx);
        const mid = Math.floor((segRangeStart + segRangeEnd) / 2);
        update(2 * nodeIdx, segRangeStart, mid, updateStart, updateEnd, delta);
        update(2 * nodeIdx + 1, mid + 1, segRangeEnd, updateStart, updateEnd, delta);
        tree[nodeIdx].max_val = Math.max(tree[2 * nodeIdx].max_val, tree[2 * nodeIdx + 1].max_val);
    }

    function query(nodeIdx, segRangeStart, segRangeEnd, queryStart, queryEnd) {
        // No overlap
        if (queryStart > segRangeEnd || queryEnd < segRangeStart) {
            return 0; // Blessing force is non-negative
        }

        // Full overlap
        if (queryStart <= segRangeStart && segRangeEnd <= queryEnd) {
            return tree[nodeIdx].max_val;
        }

        // Partial overlap
        pushDown(nodeIdx);
        const mid = Math.floor((segRangeStart + segRangeEnd) / 2);
        const leftMax = query(2 * nodeIdx, segRangeStart, mid, queryStart, queryEnd);
        const rightMax = query(2 * nodeIdx + 1, mid + 1, segRangeEnd, queryStart, queryEnd);
        return Math.max(leftMax, rightMax);
    }

    // Step 2: Create events
    const events = [];
    const RECT_ADD = 0;
    const QUERY_START = 1;
    const QUERY_END = 2;
    const RECT_REMOVE = 3;

    for (const [x, y, w, h] of rectangles) {
        // Rectangle [x, y, x+w, y+h]
        // Add event at x
        events.push([x, RECT_ADD, y, y + h, -1]);
        // Remove event at x+w+1 (exclusive end)
        events.push([x + w + 1, RECT_REMOVE, y, y + h, -1]);
    }

    for (let i = 0; i < queries.length; i++) {
        const [x, y, w, h] = queries[i];
        // Query rectangle [x, y, x+w, y+h]
        // Query start event at x
        events.push([x, QUERY_START, y, y + h, i]);
        // Query end event at x+w+1 (exclusive end)
        events.push([x + w + 1, QUERY_END, y, y + h, i]);
    }

    // Step 3: Sort events
    // Primary sort by x-coordinate
    // Secondary sort by type: RECT_ADD < QUERY_START < QUERY_END < RECT_REMOVE
    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    // Step 4: Process events using sweep line
    const answers = new Array(queries.length).fill(0);

    for (const [x, type, y1, y2, queryIdx] of events) {
        // Map y-coordinates to segment tree indices.
        // A rectangle [Y_start, Y_end] (inclusive) covers segments
        // from yCoords[start_idx] to yCoords[end_idx+1]-1.
        // So, the segment tree update/query range is [start_idx, end_idx].
        // start_idx = yMap.get(Y_start)
        // end_idx = yMap.get(Y_end)
        // This is incorrect. The segment tree operates on indices 0 to numSegments-1.
        // Each index `k` corresponds to the interval `[yCoords[k], yCoords[k+1]-1]`.
        // So for an original range `[Y_start, Y_end]` (inclusive), we need to find:
        // `seg_start_idx`: the smallest `k` such that `yCoords[k] >= Y_start`.
        // `seg_end_idx`: the largest `k` such that `yCoords[k+1]-1 <= Y_end`.
        // This is equivalent to finding `lower_bound(yCoords, Y_start)` for `seg_start_idx`
        // and `lower_bound(yCoords, Y_end + 1) - 1` for `seg_end_idx`.

        const updateRangeStart = yMap.get(y1);
        const updateRangeEnd = yMap.get(y2 + 1) - 1; // y2+1 is exclusive upper bound

        // If the y-range is empty (e.g., y1 > y2) or maps to an invalid segment range.
        if (updateRangeStart === undefined || updateRangeEnd === undefined || updateRangeStart > updateRangeEnd) {
            continue;
        }

        if (type === RECT_ADD) {
            update(1, 0, numSegments - 1, updateRangeStart, updateRangeEnd, 1);
        } else if (type === RECT_REMOVE) {
            update(1, 0, numSegments - 1, updateRangeStart, updateRangeEnd, -1);
        } else if (type === QUERY_START || type === QUERY_END) {
            // For queries, we query the current max blessing in their y-range
            // and update the overall max for that query.
            const currentMaxBlessing = query(1, 0, numSegments - 1, updateRangeStart, updateRangeEnd);
            answers[queryIdx] = Math.max(answers[queryIdx], currentMaxBlessing);
        }
    }

    return answers;
};