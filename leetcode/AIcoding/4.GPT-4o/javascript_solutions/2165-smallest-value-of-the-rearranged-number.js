var smallestNumber = function(num) {
    let isNegative = num < 0;
    let digits = Math.abs(num).toString().split('').sort();

    if (isNegative) {
        return -parseInt(digits.reverse().join(''));
    }

    while (digits[0] === '0') {
        digits.shift();
    }

    if (digits.length > 0) {
        digits.unshift('0');
    }

    return parseInt(digits.join(''));
};