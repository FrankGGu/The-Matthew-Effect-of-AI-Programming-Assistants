var distinctNumbersOnBoard = function(n) {
    let set = new Set();
    let count = 0;
    while (n > 0) {
        set.add(n);
        n = Math.floor(n / 10);
    }
    return set.size;
};