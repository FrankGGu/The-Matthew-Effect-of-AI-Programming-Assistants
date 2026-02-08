var myAtoi = function(s) {
    s = s.trim();
    if (s.length === 0) return 0;

    let index = 0, sign = 1, total = 0;
    const INT_MAX = 2**31 - 1, INT_MIN = -2**31;

    if (s[index] === '-' || s[index] === '+') {
        sign = s[index] === '-' ? -1 : 1;
        index++;
    }

    while (index < s.length && s[index] >= '0' && s[index] <= '9') {
        total = total * 10 + (s[index] - '0');
        index++;

        if (sign === 1 && total >= INT_MAX) return INT_MAX;
        if (sign === -1 && total * sign <= INT_MIN) return INT_MIN;
    }

    return total * sign;
};