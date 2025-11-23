class SegmentTree {
    constructor(size) {
        this.size = size;
        this.tree = new Array(4 * size).fill(0);
    }

    update(index, value) {
        this._update(1, 0, this.size - 1, index, value);
    }

    _update(node, start, end, index, value) {
        if (start === end) {
            this.tree[node] = Math.max(this.tree[node], value);
        } else {
            const mid = Math.floor((start + end) / 2);
            if (index <= mid) {
                this._update(node * 2, start, mid, index, value);
            } else {
                this._update(node * 2 + 1, mid + 1, end, index, value);
            }
            this.tree[node] = Math.max(this.tree[node * 2], this.tree[node * 2 + 1]);
        }
    }

    query(left, right) {
        return this._query(1, 0, this.size - 1, left, right);
    }

    _query(node, start, end, left, right) {
        if (right < start || end < left) return 0;
        if (left <= start && end <= right) return this.tree[node];
        const mid = Math.floor((start + end) / 2);
        return Math.max(this._query(node * 2, start, mid, left, right), this._query(node * 2 + 1, mid + 1, end, left, right));
    }
}

var maxPoints = function(points, queries) {
    const n = points.length;
    const m = queries.length;
    const results = new Array(m);

    points.sort((a, b) => a[0] - b[0]);
    const segmentTree = new SegmentTree(100001);

    let j = 0;
    const indexedQueries = queries.map((q, i) => [q[0], q[1], i]).sort((a, b) => a[0] - b[0]);

    for (let i = 0; i < m; i++) {
        const [xq, yq, index] = indexedQueries[i];

        while (j < n && points[j][0] <= xq) {
            segmentTree.update(points[j][1], points[j][2]);
            j++;
        }

        results[index] = segmentTree.query(0, yq);
    }

    return results;
};