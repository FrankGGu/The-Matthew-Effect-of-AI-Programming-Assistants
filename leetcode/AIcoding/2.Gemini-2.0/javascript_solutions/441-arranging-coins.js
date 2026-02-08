var arrangeCoins = function(n) {
    let k = 0;
    while (n >= k + 1) {
        k++;
        n -= k;
    }
    return k;
};