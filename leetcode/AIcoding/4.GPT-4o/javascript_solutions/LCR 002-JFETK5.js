var addBinary = function(a, b) {
    let carry = 0, result = '';
    let maxLength = Math.max(a.length, b.length);

    for (let i = 0; i < maxLength; i++) {
        const bitA = a.length - 1 - i >= 0 ? a[a.length - 1 - i] - '0' : 0;
        const bitB = b.length - 1 - i >= 0 ? b[b.length - 1 - i] - '0' : 0;

        const sum = bitA + bitB + carry;
        result = (sum % 2) + result;
        carry = Math.floor(sum / 2);
    }

    if (carry) {
        result = carry + result;
    }

    return result;
};