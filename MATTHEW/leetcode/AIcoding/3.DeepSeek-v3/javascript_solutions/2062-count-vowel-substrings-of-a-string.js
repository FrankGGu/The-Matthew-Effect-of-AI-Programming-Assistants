var countVowelSubstrings = function(word) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const n = word.length;

    for (let i = 0; i < n; i++) {
        const currentChars = new Set();
        for (let j = i; j < n; j++) {
            if (!vowels.has(word[j])) {
                break;
            }
            currentChars.add(word[j]);
            if (currentChars.size === 5) {
                count++;
            }
        }
    }

    return count;
};