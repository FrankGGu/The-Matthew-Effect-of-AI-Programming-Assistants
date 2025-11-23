function myAtoi(s) {
    const INT_MAX = 2147483647;
    const INT_MIN = -2147483648;
    let i = 0;
    while (i < s.length && s[i] === ' ') {
        i++;
    }
    if (i >= s.length) return 0;
    let sign = 1;
    if (s[i] === '-') {
        sign = -1;
        i++;
    } else if (s[i] === '+') {
        i++;
    }
    let result = 0;
    while (i < s.length && s[i] >= '0' && s[i] <= '9') {
        let digit = parseInt(s[i], 10);
        if (result > Math.floor(INT_MAX / 10) || (result === Math.floor(INT_MAX / 10) && digit > INT_MAX % 10)) {
            return sign === 1 ? INT_MAX : INT_MIN;
        }
        result = result * 10 + digit;
        i++;
    }
    return sign * result;
}