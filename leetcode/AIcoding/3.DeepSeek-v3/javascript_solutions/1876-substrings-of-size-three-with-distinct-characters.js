var countGoodSubstrings = function(s) {
    let count = 0;
    for (let i = 0; i <= s.length - 3; i++) {
        const substr = s.substring(i, i + 3);
        const set = new Set(substr);
        if (set.size === 3) {
            count++;
        }
    }
    return count;
};