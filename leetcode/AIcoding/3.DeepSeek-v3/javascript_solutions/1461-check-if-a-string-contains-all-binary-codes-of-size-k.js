var hasAllCodes = function(s, k) {
    const needed = 1 << k;
    const seen = new Set();
    for (let i = 0; i <= s.length - k; i++) {
        const substring = s.substr(i, k);
        seen.add(substring);
        if (seen.size === needed) {
            return true;
        }
    }
    return false;
};