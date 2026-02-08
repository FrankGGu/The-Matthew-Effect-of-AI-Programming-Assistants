var toHex = function(num) {
    if (num === 0) {
        return "0";
    }

    const hexChars = "0123456789abcdef";
    let hex = "";

    // Use unsigned right shift (>>>) to correctly handle negative numbers
    // by treating them as unsigned 32-bit integers.
    // Each iteration processes 4 bits (one hexadecimal digit).
    while (num !== 0) {
        const digit = num & 15; // Get the last 4 bits (0-15)
        hex = hexChars[digit] + hex; // Prepend the corresponding hex character
        num >>>= 4; // Unsigned right shift by 4 bits
    }

    return hex;
};