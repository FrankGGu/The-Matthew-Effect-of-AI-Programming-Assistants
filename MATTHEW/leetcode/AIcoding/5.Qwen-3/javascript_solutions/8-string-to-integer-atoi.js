var myAtoi = function(str) {
    const INT_MAX = 2147483647;
    const INT_MIN = -2147483648;
    let i = 0;
    while (i < str.length && str[i] === ' ') {
        i++;
    }
    let sign = 1;
    if (i < str.length && str[i] === '-') {
        sign = -1;
        i++;
    } else if (i < str.length && str[i] === '+') {
        i++;
    }
    let result = 0;
    while (i < str.length && str[i] >= '0' && str[i] <= '9') {
        let digit = parseInt(str[i], 10);
        result = result * 10 + digit;
        if (sign === 1 && result > INT_MAX) {
            return INT_MAX;
        }
        if (sign === -1 && result > Math.abs(INT_MIN)) {
            return INT_MIN;
        }
        i++;
    }
    return sign * result;
};