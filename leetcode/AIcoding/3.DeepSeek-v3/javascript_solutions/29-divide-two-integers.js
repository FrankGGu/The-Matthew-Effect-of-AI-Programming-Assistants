var divide = function(dividend, divisor) {
    if (dividend === -2147483648 && divisor === -1) return 2147483647;

    let negative = (dividend > 0) ^ (divisor > 0) ? true : false;
    dividend = Math.abs(dividend);
    divisor = Math.abs(divisor);

    let result = 0;
    while (dividend >= divisor) {
        let value = divisor;
        let power = 1;
        while (value + value <= dividend) {
            value += value;
            power += power;
        }
        dividend -= value;
        result += power;
    }

    if (negative) result = -result;
    return Math.min(Math.max(result, -2147483648), 2147483647);
};