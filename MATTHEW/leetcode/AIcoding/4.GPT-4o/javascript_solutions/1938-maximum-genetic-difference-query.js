class SegmentTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(4 * size).fill(0);
    }

    build(arr, node, start, end) {
        if (start === end) {
            this.tree[node] = arr[start];
        } else {
            const mid = Math.floor((start + end) / 2);
            this.build(arr, 2 * node + 1, start, mid);
            this.build(arr, 2 * node + 2, mid + 1, end);
            this.tree[node] = this.tree[2 * node + 1] ^ this.tree[2 * node + 2];
        }
    }

    query(node, start, end, L, R) {
        if (R < start || end < L) {
            return 0;
        }
        if (L <= start && end <= R) {
            return this.tree[node];
        }
        const mid = Math.floor((start + end) / 2);
        const leftQuery = this.query(2 * node + 1, start, mid, L, R);
        const rightQuery = this.query(2 * node + 2, mid + 1, end, L, R);
        return leftQuery ^ rightQuery;
    }
}

var maximumGeneticDifference = function(parents, queries) {
    const n = parents.length;
    const values = Array.from({ length: n }, (_, i) => i);
    const segTree = new SegmentTree(n);
    segTree.build(values, 0, 0, n - 1);

    const results = [];
    for (const [u, v] of queries) {
        const l = Math.min(u, v);
        const r = Math.max(u, v);
        results.push(segTree.query(0, 0, n - 1, l, r));
    }
    return results;
};