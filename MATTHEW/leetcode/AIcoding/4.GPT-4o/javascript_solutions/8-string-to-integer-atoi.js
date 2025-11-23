var myAtoi = function(s) {
    let i = 0, n = s.length, sign = 1, num = 0;

    while (i < n && s[i] === ' ') i++;
    if (i < n && (s[i] === '-' || s[i] === '+')) {
        sign = s[i] === '-' ? -1 : 1;
        i++;
    }

    while (i < n && s[i] >= '0' && s[i] <= '9') {
        num = num * 10 + (s[i] - '0');
        i++;

        if (num > 2147483647) {
            return sign === 1 ? 2147483647 : -2147483648;
        }
    }

    return num * sign;
};