var reformatNumber = function(s) {
    const digits = s.replace(/[- ]/g, '');
    const n = digits.length;
    const result = [];
    let i = 0;

    while (i < n) {
        const remainingLength = n - i;

        if (remainingLength === 4) {
            result.push(digits.substring(i, i + 2));
            result.push(digits.substring(i + 2, i + 4));
            i += 4;
        } else if (remainingLength === 2 || remainingLength === 3) {
            result.push(digits.substring(i, i + remainingLength));
            i += remainingLength;
        } else {
            result.push(digits.substring(i, i + 3));
            i += 3;
        }
    }

    return result.join('-');
};