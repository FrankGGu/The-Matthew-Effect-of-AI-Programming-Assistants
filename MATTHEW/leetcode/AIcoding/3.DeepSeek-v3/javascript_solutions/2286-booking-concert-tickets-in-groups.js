class BookMyShow {
    constructor(n, m) {
        this.n = n;
        this.m = m;
        this.seats = new Array(n).fill(0);
        this.maxTree = new Array(4 * n).fill(0);
        this.sumTree = new Array(4 * n).fill(0);
        this.build(0, n - 1, 0);
    }

    build(l, r, idx) {
        if (l === r) {
            this.maxTree[idx] = this.m;
            this.sumTree[idx] = this.m;
            return;
        }
        const mid = Math.floor((l + r) / 2);
        this.build(l, mid, 2 * idx + 1);
        this.build(mid + 1, r, 2 * idx + 2);
        this.maxTree[idx] = Math.max(this.maxTree[2 * idx + 1], this.maxTree[2 * idx + 2]);
        this.sumTree[idx] = this.sumTree[2 * idx + 1] + this.sumTree[2 * idx + 2];
    }

    maxQuery(l, r, idx, ql, qr) {
        if (ql > r || qr < l) return 0;
        if (ql <= l && qr >= r) return this.maxTree[idx];
        const mid = Math.floor((l + r) / 2);
        return Math.max(
            this.maxQuery(l, mid, 2 * idx + 1, ql, qr),
            this.maxQuery(mid + 1, r, 2 * idx + 2, ql, qr)
        );
    }

    sumQuery(l, r, idx, ql, qr) {
        if (ql > r || qr < l) return 0;
        if (ql <= l && qr >= r) return this.sumTree[idx];
        const mid = Math.floor((l + r) / 2);
        return this.sumQuery(l, mid, 2 * idx + 1, ql, qr) + this.sumQuery(mid + 1, r, 2 * idx + 2, ql, qr);
    }

    update(l, r, idx, pos, val) {
        if (l === r) {
            this.maxTree[idx] = val;
            this.sumTree[idx] = val;
            return;
        }
        const mid = Math.floor((l + r) / 2);
        if (pos <= mid) {
            this.update(l, mid, 2 * idx + 1, pos, val);
        } else {
            this.update(mid + 1, r, 2 * idx + 2, pos, val);
        }
        this.maxTree[idx] = Math.max(this.maxTree[2 * idx + 1], this.maxTree[2 * idx + 2]);
        this.sumTree[idx] = this.sumTree[2 * idx + 1] + this.sumTree[2 * idx + 2];
    }

    gather(k, maxRow) {
        let low = 0;
        let high = maxRow;
        let row = -1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            const maxSeats = this.maxQuery(0, this.n - 1, 0, 0, mid);
            if (maxSeats >= k) {
                row = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        if (row === -1) return [];
        const seats = this.seats[row];
        const start = this.m - seats;
        this.seats[row] += k;
        this.update(0, this.n - 1, 0, row, this.m - this.seats[row]);
        return [row, start];
    }

    scatter(k, maxRow) {
        const total = this.sumQuery(0, this.n - 1, 0, 0, maxRow);
        if (total < k) return false;
        let remaining = k;
        let row = 0;
        while (remaining > 0) {
            const available = this.m - this.seats[row];
            const take = Math.min(available, remaining);
            this.seats[row] += take;
            this.update(0, this.n - 1, 0, row, this.m - this.seats[row]);
            remaining -= take;
            row++;
        }
        return true;
    }
}