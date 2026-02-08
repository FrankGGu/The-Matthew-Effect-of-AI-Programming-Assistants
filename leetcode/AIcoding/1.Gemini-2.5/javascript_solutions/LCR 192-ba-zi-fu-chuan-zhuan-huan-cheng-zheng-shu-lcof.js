var myAtoi = function(s) {
    let i = 0;
    const n = s.length;

    while (i < n && s[i] === ' ') {
        i++;
    }

    if (i === n) {
        return 0;
    }

    let sign = 1;
    if (s[i] === '-') {
        sign = -1;
        i++;
    } else if (s[i] === '+') {
        i++;
    }

    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    let result = 0;

    while (i < n) {
        const charCode = s.charCodeAt(i);
        if (charCode < 48 || charCode > 57) {
            break;
        }

        const digit = charCode - 48;

        if (sign === 1) {
            if (result > Math.floor(MAX_INT / 10) || (result === Math.floor(MAX_INT / 10) && digit > 7)) {
                return MAX_INT;
            }
        } else {
            if (result > Math.floor(MAX_INT / 10) || (result === Math.floor(MAX_INT / 10) && digit > 8)) {
                return MIN_INT;
            }
        }

        result = result * 10 + digit;
        i++;
    }

    return result * sign;
};