var hasAllCodes = function(s, k) {
    const required = 1 << k;
    const seen = new Set();
    for (let i = 0; i <= s.length - k; i++) {
        const sub = s.substring(i, i + k);
        seen.add(sub);
    }
    return seen.size === required;
};