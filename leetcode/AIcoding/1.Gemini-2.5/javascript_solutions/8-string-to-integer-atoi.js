var myAtoi = function(s) {
    let i = 0;
    const n = s.length;

    while (i < n && s[i] === ' ') {
        i++;
    }

    let sign = 1;
    if (i < n && (s[i] === '+' || s[i] === '-')) {
        sign = (s[i] === '-') ? -1 : 1;
        i++;
    }

    let result = 0;
    const MAX_INT = 2147483647;
    const MIN_INT = -2147483648;

    while (i < n) {
        const charCode = s.charCodeAt(i);
        if (charCode < 48 || charCode > 57) { // Not a digit
            break;
        }

        const digit = charCode - 48;

        // Check for overflow before adding the digit
        if (sign === 1) {
            if (result > Math.floor(MAX_INT / 10) || (result === Math.floor(MAX_INT / 10) && digit > 7)) {
                return MAX_INT;
            }
        } else { // sign === -1
            if (result < Math.ceil(MIN_INT / 10) || (result === Math.ceil(MIN_INT / 10) && digit > 8)) {
                return MIN_INT;
            }
        }

        result = result * 10 + digit;
        i++;
    }

    return result * sign;
};