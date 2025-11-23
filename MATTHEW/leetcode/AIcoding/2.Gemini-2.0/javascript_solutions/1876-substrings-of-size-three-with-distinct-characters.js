var countGoodSubstrings = function(s) {
    let count = 0;
    for (let i = 0; i <= s.length - 3; i++) {
        let sub = s.substring(i, i + 3);
        if (new Set(sub).size === 3) {
            count++;
        }
    }
    return count;
};