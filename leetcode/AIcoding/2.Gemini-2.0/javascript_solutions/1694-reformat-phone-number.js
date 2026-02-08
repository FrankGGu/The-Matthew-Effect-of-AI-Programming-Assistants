var reformatNumber = function(number) {
    const digits = number.replace(/[^0-9]/g, '');
    let result = '';
    let i = 0;
    while (i < digits.length - 4) {
        result += digits.substring(i, i + 3) + '-';
        i += 3;
    }
    if (digits.length - i === 4) {
        result += digits.substring(i, i + 2) + '-' + digits.substring(i + 2, i + 4);
    } else if (digits.length - i === 3) {
        result += digits.substring(i, i + 3);
    } else if (digits.length - i === 2) {
        result += digits.substring(i, i + 2);
    } else if (digits.length - i === 1) {
        result += digits.substring(i, i+1);
    }

    return result;
};