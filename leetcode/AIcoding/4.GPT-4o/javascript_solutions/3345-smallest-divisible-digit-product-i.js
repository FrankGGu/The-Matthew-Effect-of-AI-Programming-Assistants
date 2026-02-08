var smallestDivisible = function(n) {
    for (let i = 1; i <= 1000; i++) {
        if (i % n === 0) {
            return i;
        }
    }
    return -1;
};