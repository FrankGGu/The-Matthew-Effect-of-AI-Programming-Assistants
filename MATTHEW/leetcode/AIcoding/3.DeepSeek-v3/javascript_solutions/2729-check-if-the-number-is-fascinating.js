var isFascinating = function(n) {
    const concatenated = n.toString() + (2 * n).toString() + (3 * n).toString();
    if (concatenated.length !== 9) return false;
    const digits = new Set();
    for (const char of concatenated) {
        if (char === '0' || digits.has(char)) {
            return false;
        }
        digits.add(char);
    }
    return true;
};