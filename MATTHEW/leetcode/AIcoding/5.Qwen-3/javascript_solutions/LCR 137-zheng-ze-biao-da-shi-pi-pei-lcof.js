function isMatch(s, p) {
    const dp = (i, j) => {
        if (j === p.length) return i === s.length;
        if (p[j] === '*') {
            return dp(i, j + 1) || (i < s.length && dp(i + 1, j));
        } else {
            return i < s.length && (p[j] === '?' || s[i] === p[j]) && dp(i + 1, j + 1);
        }
    };
    return dp(0, 0);
}