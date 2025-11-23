var Solution = function(n, blacklist) {
    const map = {};
    let size = n - blacklist.length;
    const blackSet = new Set(blacklist);

    for (const b of blacklist) {
        if (b >= size) {
            map[b] = 1;
        }
    }

    let last = n - 1;

    for (const b of blacklist) {
        if (b < size) {
            while (last in map || last in blackSet) {
                last--;
            }
            map[b] = last;
            last--;
        }
    }

    this.n = n;
    this.map = map;
};

Solution.prototype.pick = function() {
    let rand = Math.floor(Math.random() * this.n);
    return this.map[rand] !== undefined ? this.map[rand] : rand;
};