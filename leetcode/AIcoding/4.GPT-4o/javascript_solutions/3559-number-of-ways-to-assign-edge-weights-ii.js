class SegTree {
    constructor(n) {
        this.n = n;
        this.tree = Array(4 * n).fill(0);
    }

    update(index, value, node = 1, start = 0, end = this.n - 1) {
        if (start === end) {
            this.tree[node] += value;
        } else {
            const mid = Math.floor((start + end) / 2);
            if (index <= mid) {
                this.update(index, value, node * 2, start, mid);
            } else {
                this.update(index, value, node * 2 + 1, mid + 1, end);
            }
            this.tree[node] = this.tree[node * 2] + this.tree[node * 2 + 1];
        }
    }

    query(left, right, node = 1, start = 0, end = this.n - 1) {
        if (right < start || left > end) return 0;
        if (left <= start && end <= right) return this.tree[node];
        const mid = Math.floor((start + end) / 2);
        return this.query(left, right, node * 2, start, mid) +
               this.query(left, right, node * 2 + 1, mid + 1, end);
    }
}

var countWays = function (n, edges) {
    const segTree = new SegTree(n);
    const mod = 1000000007;
    let result = 0;

    for (const [u, v] of edges) {
        const countU = segTree.query(u, u);
        const countV = segTree.query(v, v);
        result = (result + (countU + countV)) % mod;
        segTree.update(u, 1);
        segTree.update(v, 1);
    }

    return result;
};