function reformatNumber(number) {
    const digits = number.replace(/\D/g, '');
    let result = '';
    let i = 0;

    while (i < digits.length) {
        if (i + 2 < digits.length) {
            result += digits.slice(i, i + 3) + '-';
            i += 3;
        } else if (i + 1 === digits.length) {
            result += digits[i];
            i++;
        } else {
            result += digits.slice(i, i + 2) + '-';
            i += 2;
        }
    }

    return result.endsWith('-') ? result.slice(0, -1) : result;
}