var countSubstrings = function(s, k) {
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        const freq = {};
        let maxFreq = 0;
        for (let j = i; j < n; j++) {
            const char = s[j];
            freq[char] = (freq[char] || 0) + 1;
            maxFreq = Math.max(maxFreq, freq[char]);
            if (maxFreq >= k) {
                count++;
            }
        }
    }
    return count;
};