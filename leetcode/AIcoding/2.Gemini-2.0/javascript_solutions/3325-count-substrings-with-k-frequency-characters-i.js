var countSubstrings = function(s, k) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            const sub = s.substring(i, j + 1);
            const freq = {};
            for (let char of sub) {
                freq[char] = (freq[char] || 0) + 1;
            }
            let kFreqChars = 0;
            for (let char in freq) {
                if (freq[char] === k) {
                    kFreqChars++;
                }
            }
            if (kFreqChars > 0) {
                count++;
            }
        }
    }
    return count;
};