function toHex(num) {
    if (num === 0) return "0";
    const hexChars = "0123456789abcdef";
    let result = "";
    while (num !== 0) {
        result = hexChars[num & 15] + result;
        num >>>= 4;
    }
    return result;
}