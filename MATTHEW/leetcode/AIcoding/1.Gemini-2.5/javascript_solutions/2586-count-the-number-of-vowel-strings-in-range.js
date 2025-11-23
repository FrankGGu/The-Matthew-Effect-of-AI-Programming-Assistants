var vowelStrings = function(words, left, right) {
    let count = 0;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);

    for (let i = left; i <= right; i++) {
        const word = words[i];
        const firstChar = word[0];
        const lastChar = word[word.length - 1];

        if (vowels.has(firstChar) && vowels.has(lastChar)) {
            count++;
        }
    }

    return count;
};