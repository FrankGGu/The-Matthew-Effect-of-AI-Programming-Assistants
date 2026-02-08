var countVowelConsonantSubstrings = function(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;

    for (let start = 0; start < s.length; start++) {
        const freq = {};
        let vowelCount = 0;
        let consonantCount = 0;

        for (let end = start; end < s.length; end++) {
            const char = s[end];
            if (vowels.has(char)) {
                if (!freq[char]) {
                    vowelCount++;
                }
                freq[char] = (freq[char] || 0) + 1;
            } else {
                if (freq[char]) {
                    freq[char]++;
                } else {
                    freq[char] = 1;
                }
                consonantCount++;
            }

            if (vowelCount === 5 && consonantCount >= k) {
                count++;
            }
        }
    }

    return count;
};