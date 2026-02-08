var integerBreak = function(n) {
    if (n <= 3) {
        return n - 1;
    }
    let quotient = Math.floor(n / 3);
    let remainder = n % 3;

    if (remainder === 0) {
        return Math.pow(3, quotient);
    } else if (remainder === 1) {
        return Math.pow(3, quotient - 1) * 4;
    } else {
        return Math.pow(3, quotient) * 2;
    }
};