var toHex = function(num) {
    if (num === 0) return "0";
    const hexChars = '0123456789abcdef';
    let result = '';
    for (let i = 0; i < 8 && num !== 0; i++) {
        result = hexChars[num & 0xf] + result;
        num >>>= 4;
    }
    return result;
};