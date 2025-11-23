var vowelStrings = function(words, left, right) {
    let count = 0;
    const vowels = ['a', 'e', 'i', 'o', 'u'];

    for (let i = left; i <= right; i++) {
        const word = words[i];
        if (vowels.includes(word[0]) && vowels.includes(word[word.length - 1])) {
            count++;
        }
    }

    return count;
};