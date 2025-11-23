var Solution = function(N, blacklist) {
    this.size = N - blacklist.length;
    this.map = new Map();
    const set = new Set(blacklist);
    let last = N - 1;

    for (const b of blacklist) {
        if (b >= this.size) {
            while (set.has(last)) last--;
            this.map.set(b, last);
            last--;
        }
    }
};

Solution.prototype.pick = function() {
    const index = Math.floor(Math.random() * this.size);
    return this.map.get(index) !== undefined ? this.map.get(index) : index;
};