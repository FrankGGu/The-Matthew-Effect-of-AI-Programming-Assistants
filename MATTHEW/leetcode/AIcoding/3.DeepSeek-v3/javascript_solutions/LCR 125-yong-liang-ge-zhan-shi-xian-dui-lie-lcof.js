var BookMyShow = function(n, m) {
    this.n = n;
    this.m = m;
    this.min = new Array(n * 4).fill(0);
    this.sum = new Array(n * 4).fill(0);
};

BookMyShow.prototype.gather = function(k, maxRow) {
    function queryGather(node, l, r, R, val) {
        if (this.min[node] > this.m - val) return [];
        if (l > R) return [];
        if (l === r) {
            return [l, this.m - this.min[node] - val];
        }
        const mid = Math.floor((l + r) / 2);
        const leftResult = queryGather.call(this, node * 2, l, mid, R, val);
        if (leftResult.length) return leftResult;
        return queryGather.call(this, node * 2 + 1, mid + 1, r, R, val);
    }
    const res = queryGather.call(this, 1, 0, this.n - 1, maxRow, k);
    if (res.length) {
        this.update(1, 0, this.n - 1, res[0], this.min[this.getIndex(res[0])] + k);
    }
    return res;
};

BookMyShow.prototype.scatter = function(k, maxRow) {
    function queryScatter(node, l, r, R) {
        if (l > R) return 0;
        if (r <= R) return this.sum[node];
        const mid = Math.floor((l + r) / 2);
        return queryScatter.call(this, node * 2, l, mid, R) + queryScatter.call(this, node * 2 + 1, mid + 1, r, R);
    }
    const total = queryScatter.call(this, 1, 0, this.n - 1, maxRow);
    if (total + k > (maxRow + 1) * this.m) return false;

    let remaining = k;
    function updateScatter(node, l, r) {
        if (remaining === 0) return;
        if (l === r) {
            const add = Math.min(remaining, this.m - this.min[this.getIndex(l)]);
            this.update(1, 0, this.n - 1, l, this.min[this.getIndex(l)] + add);
            remaining -= add;
            return;
        }
        const mid = Math.floor((l + r) / 2);
        const leftAvailable = (mid - l + 1) * this.m - queryScatter.call(this, node * 2, l, mid, mid);
        if (leftAvailable > 0) {
            updateScatter.call(this, node * 2, l, mid);
        }
        if (remaining > 0) {
            updateScatter.call(this, node * 2 + 1, mid + 1, r);
        }
    }
    updateScatter.call(this, 1, 0, this.n - 1);
    return true;
};

BookMyShow.prototype.getIndex = function(pos) {
    return pos + this.n;
};

BookMyShow.prototype.update = function(node, l, r, pos, val) {
    if (l === r) {
        this.min[node] = val;
        this.sum[node] = val;
        return;
    }
    const mid = Math.floor((l + r) / 2);
    if (pos <= mid) {
        this.update(node * 2, l, mid, pos, val);
    } else {
        this.update(node * 2 + 1, mid + 1, r, pos, val);
    }
    this.min[node] = Math.min(this.min[node * 2], this.min[node * 2 + 1]);
    this.sum[node] = this.sum[node * 2] + this.sum[node * 2 + 1];
};