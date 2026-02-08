var getTriggerTime = function(plots, events) {
    const n = plots.length;
    const m = events.length;

    // 1. Coordinate compression for B values
    // Collect all unique B values from plots and events
    const allBValues = new Set();
    for (const plot of plots) {
        allBValues.add(plot[2]);
    }
    for (const event of events) {
        allBValues.add(event[2]);
    }

    // Sort unique B values and create a map from value to compressed coordinate
    const sortedBValues = Array.from(allBValues).sort((a, b) => a - b);
    const bMap = new Map();
    sortedBValues.forEach((val, index) => bMap.set(val, index));
    const maxBCoord = sortedBValues.length; // Number of unique B values

    // 2. Prepare items for sweep-line
    // Each item represents either a plot or an event
    const items = [];
    for (let i = 0; i < n; i++) {
        const [c, a, b] = plots[i];
        // For plots, we store required c, a, compressed b, type, and original plot index
        items.push({ val1: c, val2: a, type: 'plot', bCoord: bMap.get(b), id: i });
    }
    for (let i = 0; i < m; i++) {
        const [C, A, B] = events[i];
        // For events, we store current C, A, compressed B, type, and original event index
        items.push({ val1: C, val2: A, type: 'event', bCoord: bMap.get(B), id: i });
    }

    // 3. Sort items for sweep-line
    // Sorting order:
    // 1. By val1 (C/c) in descending order. This ensures that when we process a plot, all events with C_j >= c_i are already considered.
    // 2. If val1 is equal, by val2 (A/a) in descending order. This ensures that for same C, all events with A_j >= a_i are considered.
    // 3. If val1 and val2 are equal, events are processed before plots. This allows an event at (C,A,B) to satisfy a plot at (c=C, a=A, b) immediately.
    items.sort((p1, p2) => {
        if (p1.val1 !== p2.val1) return p2.val1 - p1.val1; // Descending C
        if (p1.val2 !== p2.val2) return p2.val2 - p1.val2; // Descending A
        // Events (type 0) come before plots (type 1)
        return (p1.type === 'event' ? 0 : 1) - (p2.type === 'event' ? 0 : 1);
    });

    // 4. Initialize results array for plots
    const ans = new Array(n).fill(-1);

    // 5. Segment Tree for B coordinates
    // Stores the minimum event index for a given range of compressed B coordinates.
    // Size is 4 * maxBCoord for a segment tree covering indices 0 to maxBCoord-1.
    const SEG_TREE_SIZE = 4 * maxBCoord;
    const segTree = new Array(SEG_TREE_SIZE).fill(Infinity); // Initialize with Infinity

    // Segment Tree update function: Updates the minimum event_idx at targetBCoord
    function updateSeg(nodeIdx, low, high, targetBCoord, eventIdx) {
        if (low === high) {
            segTree[nodeIdx] = Math.min(segTree[nodeIdx], eventIdx);
            return;
        }
        const mid = Math.floor((low + high) / 2);
        if (targetBCoord <= mid) {
            updateSeg(2 * nodeIdx, low, mid, targetBCoord, eventIdx);
        } else {
            updateSeg(2 * nodeIdx + 1, mid + 1, high, targetBCoord, eventIdx);
        }
        // Propagate minimum value up to parent
        segTree[nodeIdx] = Math.min(segTree[2 * nodeIdx], segTree[2 * nodeIdx + 1]);
    }

    // Segment Tree query function: Finds the minimum event_idx in range [queryBLow, queryBHigh]
    function querySeg(nodeIdx, low, high, queryBLow, queryBHigh) {
        // If query range is outside current node's range, return Infinity
        if (queryBLow > high || queryBHigh < low) {
            return Infinity;
        }
        // If current node's range is fully contained within query range, return its value
        if (queryBLow <= low && high <= queryBHigh) {
            return segTree[nodeIdx];
        }
        // Partial overlap: recurse on children and take minimum
        const mid = Math.floor((low + high) / 2);
        const res1 = querySeg(2 * nodeIdx, low, mid, queryBLow, queryBHigh);
        const res2 = querySeg(2 * nodeIdx + 1, mid + 1, high, queryBLow, queryBHigh);
        return Math.min(res1, res2);
    }

    // 6. Sweep-line processing
    // Iterate through sorted items
    for (const item of items) {
        if (item.type === 'event') {
            // If it's an event, add its original index to the segment tree at its compressed B coordinate
            updateSeg(1, 0, maxBCoord - 1, item.bCoord, item.id);
        } else {
            // If it's a plot, query the segment tree for the earliest event
            // We need events with B_k >= b_i. In compressed coordinates, this means from item.bCoord up to maxBCoord-1.
            const result = querySeg(1, 0, maxBCoord - 1, item.bCoord, maxBCoord - 1);
            if (result !== Infinity) {
                ans[item.id] = result;
            }
        }
    }

    return ans;
};