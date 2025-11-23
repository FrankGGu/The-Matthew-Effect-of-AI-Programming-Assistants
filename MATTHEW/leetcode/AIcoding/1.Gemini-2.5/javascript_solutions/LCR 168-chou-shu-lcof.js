var isUgly = function(n) {
    if (n <= 0) {
        return false;
    }
    if (n === 1) {
        return true;
    }

    const factors = [2, 3, 5];

    for (let factor of factors) {
        while (n % factor === 0) {
            n /= factor;
        }
    }

    return n === 1;
};