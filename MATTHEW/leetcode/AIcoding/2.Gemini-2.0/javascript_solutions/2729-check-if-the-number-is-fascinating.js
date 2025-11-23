var isFascinating = function(n) {
    const s = String(n) + String(2 * n) + String(3 * n);
    if (s.length !== 9) return false;
    const digits = new Set();
    for (const char of s) {
        if (char === '0' || digits.has(char)) return false;
        digits.add(char);
    }
    return true;
};