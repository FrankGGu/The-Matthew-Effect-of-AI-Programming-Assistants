var countVowelSubstrings = function(word) {
    let count = 0;
    const n = word.length;
    const allVowels = new Set(['a', 'e', 'i', 'o', 'u']);

    const isVowelChar = (char) => allVowels.has(char);

    for (let i = 0; i < n; i++) {
        const currentVowelsInSubstring = new Set();
        for (let j = i; j < n; j++) {
            const char = word[j];
            if (isVowelChar(char)) {
                currentVowelsInSubstring.add(char);
                if (currentVowelsInSubstring.size === 5) {
                    count++;
                }
            } else {
                break;
            }
        }
    }
    return count;
};