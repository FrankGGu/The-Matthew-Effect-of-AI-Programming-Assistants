function alternateDigitSum(n) {
    let sum = 0;
    let sign = 1;
    const digits = n.toString().split('').map(Number);
    for (let i = digits.length - 1; i >= 0; i--) {
        sum += sign * digits[i];
        sign *= -1;
    }
    return sum;
}