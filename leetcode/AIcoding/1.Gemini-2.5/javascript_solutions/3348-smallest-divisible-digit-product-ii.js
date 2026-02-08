var smallestDivisibleDigitProduct = function(n) {
    if (n === 1) {
        return 1;
    }

    const digits = [];
    for (let d = 9; d >= 2; d--) {
        while (n % d === 0) {
            digits.push(d);
            n /= d;
        }
    }

    if (n > 1) {
        return -1;
    }

    digits.sort((a, b) => a - b);

    return Number(digits.join(''));
};