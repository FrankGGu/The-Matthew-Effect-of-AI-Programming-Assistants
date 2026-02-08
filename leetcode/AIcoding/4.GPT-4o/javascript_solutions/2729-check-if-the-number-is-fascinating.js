var isFascinating = function(n) {
    const s = String(n) + String(n * 2) + String(n * 3);
    const digits = new Set(s);
    return digits.size === 9 && !digits.has('0');
};