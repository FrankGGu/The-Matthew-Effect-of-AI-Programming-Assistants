var longestNiceSubstring = function(s) {
    if (s.length < 2) return "";
    const set = new Set(s);
    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (!set.has(c.toLowerCase()) || !set.has(c.toUpperCase())) {
            const left = longestNiceSubstring(s.substring(0, i));
            const right = longestNiceSubstring(s.substring(i + 1));
            return left.length >= right.length ? left : right;
        }
    }
    return s;
};