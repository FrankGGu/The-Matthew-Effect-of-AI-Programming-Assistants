var countVowelSubstrings = function(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;

    for (let i = 0; i < s.length; i++) {
        const freq = { a: 0, e: 0, i: 0, o: 0, u: 0 };
        let vowelCount = 0;
        let consonantCount = 0;

        for (let j = i; j < s.length; j++) {
            if (vowels.has(s[j])) {
                if (freq[s[j]] === 0) vowelCount++;
                freq[s[j]]++;
            } else {
                consonantCount++;
            }

            if (vowelCount === 5 && consonantCount <= k) {
                count++;
            }
        }
    }

    return count;
};