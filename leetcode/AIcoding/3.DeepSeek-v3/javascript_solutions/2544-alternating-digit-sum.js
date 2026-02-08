var alternateDigitSum = function(n) {
    let sum = 0;
    let sign = 1;
    const digits = n.toString().split('');
    for (let i = 0; i < digits.length; i++) {
        sum += sign * parseInt(digits[i]);
        sign *= -1;
    }
    return sum;
};