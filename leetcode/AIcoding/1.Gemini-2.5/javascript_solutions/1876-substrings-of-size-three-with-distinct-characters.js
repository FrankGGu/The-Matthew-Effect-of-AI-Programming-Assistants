var countGoodSubstrings = function(s) {
    let count = 0;
    const n = s.length;

    for (let i = 0; i <= n - 3; i++) {
        const char1 = s[i];
        const char2 = s[i+1];
        const char3 = s[i+2];

        if (char1 !== char2 && char1 !== char3 && char2 !== char3) {
            count++;
        }
    }

    return count;
};