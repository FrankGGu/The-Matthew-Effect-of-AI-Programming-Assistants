var Solution = function(n, blacklist) {
    this.validCount = n - blacklist.length;
    this.mapping = new Map();

    const blackSet = new Set(blacklist);

    let last = n - 1;

    for (const b of blacklist) {
        if (b < this.validCount) {
            while (blackSet.has(last)) {
                last--;
            }
            this.mapping.set(b, last);
            last--;
        }
    }
};

Solution.prototype.pick = function() {
    const idx = Math.floor(Math.random() * this.validCount);

    if (this.mapping.has(idx)) {
        return this.mapping.get(idx);
    }
    return idx;
};