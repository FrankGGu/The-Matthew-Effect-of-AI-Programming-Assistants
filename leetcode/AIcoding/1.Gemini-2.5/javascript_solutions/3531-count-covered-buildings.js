var countCoveredBuildings = function(buildings) {
    const uniqueYCoords = new Set();
    for (const building of buildings) {
        uniqueYCoords.add(building[1]);
    }
    const sortedYCoords = Array.from(uniqueYCoords).sort((a, b) => a - b);
    const yToIdx = new Map();
    sortedYCoords.forEach((y, idx) => yToIdx.set(y, idx));
    const numUniqueY = sortedYCoords.length;

    buildings.sort((a, b) => {
        if (a[0] !== b[0]) return b[0] - a[0];
        if (a[1] !== b[1]) return b[1] - a[1];
        return b[2] - a[2];
    });

    const tree = new Array(4 * numUniqueY).fill(0);

    const update = (node, start, end, idx, val) => {
        if (start === end) {
            tree[node] = Math.max(tree[node], val);
            return;
        }
        const mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
    };

    const query = (node, start, end, l, r) => {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        const mid = Math.floor((start + end) / 2);
        const p1 = query(2 * node, start, mid, l, r);
        const p2 = query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(p1, p2);
    };

    let uncoveredCount = 0;
    for (const [x, y, h] of buildings) {
        const yIdx = yToIdx.get(y);

        const maxHInRelevantYRange = query(1, 0, numUniqueY - 1, yIdx, numUniqueY - 1);

        if (maxHInRelevantYRange < h) {
            uncoveredCount++;
        }

        update(1, 0, numUniqueY - 1, yIdx, h);
    }

    return uncoveredCount;
};