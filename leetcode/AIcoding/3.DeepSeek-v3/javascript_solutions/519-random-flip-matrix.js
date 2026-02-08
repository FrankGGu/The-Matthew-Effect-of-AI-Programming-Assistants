class Solution {
    constructor(m, n) {
        this.m = m;
        this.n = n;
        this.total = m * n;
        this.map = new Map();
    }

    flip() {
        const r = Math.floor(Math.random() * this.total);
        this.total--;
        const x = this.map.get(r) || r;
        this.map.set(r, this.map.get(this.total) || this.total);
        return [Math.floor(x / this.n), x % this.n];
    }

    reset() {
        this.total = this.m * this.n;
        this.map.clear();
    }
}