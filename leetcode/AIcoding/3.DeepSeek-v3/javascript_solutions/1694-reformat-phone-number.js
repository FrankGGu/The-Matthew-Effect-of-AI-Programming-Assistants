var reformatNumber = function(number) {
    let digits = number.replace(/[^0-9]/g, '');
    let result = [];
    let i = 0;
    let n = digits.length;
    while (i < n) {
        if (n - i > 4) {
            result.push(digits.substr(i, 3));
            i += 3;
        } else {
            if (n - i === 4) {
                result.push(digits.substr(i, 2));
                result.push(digits.substr(i + 2, 2));
                i += 4;
            } else {
                result.push(digits.substr(i, n - i));
                i = n;
            }
        }
    }
    return result.join('-');
};