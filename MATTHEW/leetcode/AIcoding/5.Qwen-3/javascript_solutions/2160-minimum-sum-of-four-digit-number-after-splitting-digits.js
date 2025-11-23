function minimumSum(num) {
    const digits = [];
    let n = num;
    for (let i = 0; i < 4; i++) {
        digits.push(n % 10);
        n = Math.floor(n / 10);
    }
    digits.sort((a, b) => a - b);
    return digits[0] * 10 + digits[2] + digits[1] * 10 + digits[3];
}