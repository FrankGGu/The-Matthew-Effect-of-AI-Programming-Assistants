var myAtoi = function(s) {
    let str = s.trim();
    if (!str) return 0;

    let sign = 1;
    let i = 0;

    if (str[0] === '-') {
        sign = -1;
        i++;
    } else if (str[0] === '+') {
        i++;
    }

    let result = 0;
    const MAX_INT = Math.pow(2, 31) - 1;
    const MIN_INT = Math.pow(-2, 31);

    while (i < str.length && str[i] >= '0' && str[i] <= '9') {
        let digit = parseInt(str[i]);

        if (result > Math.floor(MAX_INT / 10) || (result === Math.floor(MAX_INT / 10) && digit > 7)) {
            return sign === 1 ? MAX_INT : MIN_INT;
        }

        result = result * 10 + digit;
        i++;
    }

    return sign * result;
};