var Solution = function(n, blacklist) {
    this.size = n - blacklist.length;
    this.map = new Map();
    let last = n - 1;
    const blackSet = new Set(blacklist);

    for (const num of blacklist) {
        if (num < this.size) {
            while (blackSet.has(last)) {
                last--;
            }
            this.map.set(num, last);
            last--;
        }
    }
};

Solution.prototype.pick = function() {
    const random = Math.floor(Math.random() * this.size);
    return this.map.has(random) ? this.map.get(random) : random;
};