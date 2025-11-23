var isFascinating = function(n) {
    const s1 = String(n);
    const s2 = String(2 * n);
    const s3 = String(3 * n);

    const combined = s1 + s2 + s3;

    if (combined.length !== 9) {
        return false;
    }

    const seenDigits = new Set();
    for (let i = 0; i < combined.length; i++) {
        const digit = combined[i];
        if (digit === '0' || seenDigits.has(digit)) {
            return false;
        }
        seenDigits.add(digit);
    }

    return true;
};