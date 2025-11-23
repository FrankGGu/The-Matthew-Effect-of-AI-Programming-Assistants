var smallestNumber = function(n) {
    if (n === 0) return 0;
    if (n === 1) return 1;
    const digits = [];
    for (let i = 9; i >= 2; i--) {
        while (n % i === 0) {
            digits.push(i);
            n /= i;
        }
    }
    if (n !== 1) return -1;
    digits.sort((a, b) => a - b);
    return parseInt(digits.join(''));
};