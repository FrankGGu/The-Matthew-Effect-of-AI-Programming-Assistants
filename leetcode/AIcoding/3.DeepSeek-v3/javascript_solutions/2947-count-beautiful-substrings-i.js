var beautifulSubstrings = function(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        let vowelCount = 0;
        let consonantCount = 0;
        for (let j = i; j < n; j++) {
            if (vowels.has(s[j])) {
                vowelCount++;
            } else {
                consonantCount++;
            }
            if (vowelCount === consonantCount && (vowelCount * consonantCount) % k === 0) {
                count++;
            }
        }
    }
    return count;
};