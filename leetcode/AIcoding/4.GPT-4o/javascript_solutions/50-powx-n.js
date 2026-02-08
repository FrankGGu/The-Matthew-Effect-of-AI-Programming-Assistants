var myPow = function(x, n) {
    if (n < 0) {
        x = 1 / x;
        n = -n;
    }
    let result = 1;
    while (n) {
        if (n % 2 === 1) {
            result *= x;
        }
        x *= x;
        n = Math.floor(n / 2);
    }
    return result;
};