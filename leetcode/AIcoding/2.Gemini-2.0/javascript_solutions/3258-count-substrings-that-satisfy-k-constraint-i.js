var countSubstrings = function(s, k) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        let charCounts = {};
        let distinctCount = 0;
        for (let j = i; j < s.length; j++) {
            if (!charCounts[s[j]]) {
                charCounts[s[j]] = 0;
                distinctCount++;
            }
            charCounts[s[j]]++;
            if (distinctCount <= k) {
                count++;
            }
        }
    }
    return count;
};