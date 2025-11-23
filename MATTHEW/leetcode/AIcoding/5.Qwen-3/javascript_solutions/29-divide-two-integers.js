function divide(dividend, divisor) {
    if (dividend === -2147483648 && divisor === -1) {
        return 2147483647;
    }
    let negative = (dividend < 0) !== (divisor < 0);
    let a = Math.abs(dividend);
    let b = Math.abs(divisor);
    let result = 0;
    while (a >= b) {
        let temp = b;
        let i = 0;
        while (a >= temp) {
            temp <<= 1;
            i++;
        }
        a -= temp >> 1;
        result += 1 << (i - 1);
    }
    return negative ? -result : result;
}