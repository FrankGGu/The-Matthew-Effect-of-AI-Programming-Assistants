var toHex = function(num) {
    if (num === 0) return "0";
    let hex = "";
    const hexChars = "0123456789abcdef";
    for (let i = 0; i < 8 && num !== 0; i++) {
        hex = hexChars[num & 15] + hex;
        num >>>= 4;
    }
    return hex;
};