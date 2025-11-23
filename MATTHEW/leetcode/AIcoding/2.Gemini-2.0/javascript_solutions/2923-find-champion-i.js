var findChampion = function(n, matches) {
    const lost = new Set();
    for (const match of matches) {
        lost.add(match[1]);
    }
    for (let i = 0; i < n; i++) {
        if (!lost.has(i)) {
            return i;
        }
    }
    return -1;
};