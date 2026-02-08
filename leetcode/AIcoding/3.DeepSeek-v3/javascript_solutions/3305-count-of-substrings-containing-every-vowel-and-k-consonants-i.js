var countVowelSubstrings = function(word, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const n = word.length;

    for (let i = 0; i < n; i++) {
        const seenVowels = new Set();
        let consonantCount = 0;

        for (let j = i; j < n; j++) {
            const char = word[j];
            if (vowels.has(char)) {
                seenVowels.add(char);
            } else {
                consonantCount++;
                if (consonantCount > k) break;
            }

            if (seenVowels.size === 5 && consonantCount === k) {
                count++;
            }
        }
    }

    return count;
};