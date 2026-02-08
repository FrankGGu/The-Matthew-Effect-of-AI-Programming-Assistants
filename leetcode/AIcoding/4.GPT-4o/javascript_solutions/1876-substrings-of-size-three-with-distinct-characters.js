var countGoodSubstrings = function(s) {
    let count = 0;
    for (let i = 0; i < s.length - 2; i++) {
        const substring = s.slice(i, i + 3);
        if (new Set(substring).size === 3) {
            count++;
        }
    }
    return count;
};