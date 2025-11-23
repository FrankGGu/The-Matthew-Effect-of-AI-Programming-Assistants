var smallestNumber = function(num) {
    if (num === 0) return 0;
    const isNegative = num < 0;
    const digits = String(Math.abs(num)).split('').map(Number);

    if (isNegative) {
        digits.sort((a, b) => b - a);
        return -parseInt(digits.join(''), 10);
    } else {
        digits.sort((a, b) => a - b);
        let firstNonZero = 0;
        while (firstNonZero < digits.length && digits[firstNonZero] === 0) {
            firstNonZero++;
        }
        if (firstNonZero > 0 && firstNonZero < digits.length) {
            [digits[0], digits[firstNonZero]] = [digits[firstNonZero], digits[0]];
        }
        return parseInt(digits.join(''), 10);
    }
};