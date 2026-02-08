class BookMyShow {
    constructor(n, m) {
        this.n = n;
        this.m = m;
        this.rows = new Array(n).fill(m);
        this.min = new Array(n).fill(m);
        this.tree = new Array(4 * n).fill(0);
        this.build(0, 0, n - 1);
    }

    build(node, start, end) {
        if (start === end) {
            this.tree[node] = this.rows[start];
            return;
        }
        const mid = Math.floor((start + end) / 2);
        this.build(2 * node + 1, start, mid);
        this.build(2 * node + 2, mid + 1, end);
        this.tree[node] = Math.min(this.tree[2 * node + 1], this.tree[2 * node + 2]);
    }

    query(node, start, end, l, r, val) {
        if (this.tree[node] < val) {
            return -1;
        }

        if (start === end) {
            return start;
        }

        const mid = Math.floor((start + end) / 2);
        if (this.tree[2 * node + 1] >= val) {
            const res = this.query(2 * node + 1, start, mid, l, r, val);
            if (res !== -1) {
                return res;
            }
        }
        return this.query(2 * node + 2, mid + 1, end, l, r, val);
    }

    update(node, start, end, idx, val) {
        if (start === end) {
            this.tree[node] = val;
            return;
        }

        const mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            this.update(2 * node + 1, start, mid, idx, val);
        } else {
            this.update(2 * node + 2, mid + 1, end, idx, val);
        }
        this.tree[node] = Math.min(this.tree[2 * node + 1], this.tree[2 * node + 2]);
    }

    gather(k, maxRow) {
        const row = this.query(0, 0, this.n - 1, 0, maxRow, k);
        if (row === -1) {
            return [];
        }
        const seats = this.rows[row];
        this.rows[row] -= k;
        this.update(0, 0, this.n - 1, row, this.rows[row]);
        return [row, seats - this.rows[row]];
    }

    scatter(k, maxRow) {
        let sum = 0;
        for (let i = 0; i <= maxRow; i++) {
            sum += this.rows[i];
        }
        if (sum < k) {
            return false;
        }

        for (let i = 0; i <= maxRow; i++) {
            if (this.rows[i] >= k) {
                this.rows[i] -= k;
                this.update(0, 0, this.n - 1, i, this.rows[i]);
                return true;
            } else {
                k -= this.rows[i];
                this.rows[i] = 0;
                this.update(0, 0, this.n - 1, i, this.rows[i]);
            }
        }
        return true;
    }
}