var myAtoi = function(s) {
    let i = 0;
    let sign = 1;
    let result = 0;
    const INT_MAX = 2**31 - 1;
    const INT_MIN = -(2**31);

    while (s[i] === ' ') {
        i++;
    }

    if (s[i] === '+' || s[i] === '-') {
        sign = s[i] === '-' ? -1 : 1;
        i++;
    }

    while (i < s.length && s[i] >= '0' && s[i] <= '9') {
        const digit = s[i] - '0';
        if (result > Math.floor(INT_MAX / 10) || (result === Math.floor(INT_MAX / 10) && digit > INT_MAX % 10)) {
            return sign === 1 ? INT_MAX : INT_MIN;
        }
        result = result * 10 + digit;
        i++;
    }

    return result * sign;
};