function hasAllCodes(s, k) {
    const requiredCount = 1 << k;
    const seen = new Set();

    for (let i = 0; i <= s.length - k; i++) {
        seen.add(s.substring(i, i + k));
        if (seen.size === requiredCount) {
            return true;
        }
    }

    return false;
}