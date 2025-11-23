function alternateDigitSum(n) {
    const digits = String(n).split('').map(Number);
    let sum = 0;

    for (let i = 0; i < digits.length; i++) {
        sum += (i % 2 === 0 ? digits[i] : -digits[i]);
    }

    return sum;
}