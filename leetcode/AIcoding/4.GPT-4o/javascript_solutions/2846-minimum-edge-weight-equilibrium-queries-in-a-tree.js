class SegmentTree {
    constructor(n) {
        this.n = n;
        this.tree = new Array(4 * n).fill(0);
    }

    build(arr, node, start, end) {
        if (start === end) {
            this.tree[node] = arr[start];
        } else {
            const mid = Math.floor((start + end) / 2);
            this.build(arr, 2 * node + 1, start, mid);
            this.build(arr, 2 * node + 2, mid + 1, end);
            this.tree[node] = Math.min(this.tree[2 * node + 1], this.tree[2 * node + 2]);
        }
    }

    query(node, start, end, L, R) {
        if (R < start || end < L) {
            return Infinity;
        }
        if (L <= start && end <= R) {
            return this.tree[node];
        }
        const mid = Math.floor((start + end) / 2);
        return Math.min(
            this.query(2 * node + 1, start, mid, L, R),
            this.query(2 * node + 2, mid + 1, end, L, R)
        );
    }
}

var minEdgeWeights = function(edges, queries) {
    const n = edges.length + 1;
    const tree = new Array(n).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        tree[u].push([v, w]);
        tree[v].push([u, w]);
    }

    const weights = [];
    const dfs = (node, parent) => {
        for (const [next, weight] of tree[node]) {
            if (next !== parent) {
                weights.push(weight);
                dfs(next, node);
            }
        }
    };
    dfs(0, -1);

    const segmentTree = new SegmentTree(weights.length);
    segmentTree.build(weights, 0, 0, weights.length - 1);

    const results = [];
    for (const [u, v] of queries) {
        results.push(segmentTree.query(0, 0, weights.length - 1, u, v));
    }
    return results;
};