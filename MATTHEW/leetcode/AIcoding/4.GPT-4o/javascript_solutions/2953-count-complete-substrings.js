var countCompleteSubstrings = function(s) {
    let n = s.length, count = 0;
    let freq = new Map();

    for (let i = 0; i < n; i++) {
        freq.clear();
        let uniqueCount = 0;

        for (let j = i; j < n; j++) {
            if (!freq.has(s[j])) {
                uniqueCount++;
            }
            freq.set(s[j], (freq.get(s[j]) || 0) + 1);

            if (uniqueCount === freq.size) {
                count++;
            }
        }
    }
    return count;
};