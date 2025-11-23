var countSubstrings = function(s, k) {
    const n = s.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        const freq = new Map();
        let distinct = 0;
        for (let j = i; j < n; j++) {
            const char = s[j];
            if (!freq.has(char)) {
                freq.set(char, 0);
                distinct++;
            }
            freq.set(char, freq.get(char) + 1);
            if (distinct >= k) {
                count++;
            }
        }
    }
    return count;
};