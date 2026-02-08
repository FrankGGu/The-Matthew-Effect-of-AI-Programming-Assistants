var myAtoi = function(s) {
    let i = 0;
    let sign = 1;
    let result = 0;
    const INT_MAX = 2 ** 31 - 1;
    const INT_MIN = -(2 ** 31);

    while (s[i] === ' ') {
        i++;
    }

    if (s[i] === '+' || s[i] === '-') {
        sign = s[i] === '-' ? -1 : 1;
        i++;
    }

    while (i < s.length && s[i] >= '0' && s[i] <= '9') {
        result = result * 10 + (s[i] - '0');
        i++;
    }

    result *= sign;

    if (result > INT_MAX) {
        return INT_MAX;
    } else if (result < INT_MIN) {
        return INT_MIN;
    }

    return result;
};