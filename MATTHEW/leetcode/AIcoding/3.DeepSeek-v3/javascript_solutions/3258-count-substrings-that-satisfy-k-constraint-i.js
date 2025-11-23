var countSubstrings = function(s, k) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        const freq = {};
        let distinct = 0;
        for (let j = i; j < s.length; j++) {
            const char = s[j];
            if (!freq[char]) {
                distinct++;
                freq[char] = 1;
            } else {
                freq[char]++;
            }
            if (distinct >= k) {
                count++;
            }
        }
    }
    return count;
};