var numberOfCuts = function(n) {
    if (n % 2 === 0) {
        return n / 2;
    } else {
        return n === 1 ? 0 : n;
    }
};