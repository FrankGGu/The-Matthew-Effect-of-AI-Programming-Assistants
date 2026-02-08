var smallestValue = function(num) {
    const digits = String(Math.abs(num)).split('').map(Number).sort();
    if (num >= 0) {
        let firstNonZeroIndex = 0;
        while (firstNonZeroIndex < digits.length && digits[firstNonZeroIndex] === 0) {
            firstNonZeroIndex++;
        }
        if (firstNonZeroIndex < digits.length) {
            const temp = digits[0];
            digits[0] = digits[firstNonZeroIndex];
            digits[firstNonZeroIndex] = temp;
        }
        return parseInt(digits.join(''));
    } else {
        digits.sort((a, b) => b - a);
        return -parseInt(digits.join(''));
    }
};