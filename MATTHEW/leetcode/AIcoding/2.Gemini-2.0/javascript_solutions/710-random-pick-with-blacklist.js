var Solution = function(n, blacklist) {
    this.n = n;
    this.blacklist = new Set(blacklist);
    this.size = n - blacklist.length;
    this.map = new Map();

    for (let b of blacklist) {
        if (b < this.size) {
            while (this.blacklist.has(n - 1)) {
                n--;
            }
            this.map.set(b, n - 1);
            n--;
        }
    }
};

Solution.prototype.pick = function() {
    let index = Math.floor(Math.random() * this.size);
    if (this.map.has(index)) {
        return this.map.get(index);
    }
    return index;
};