var wordPattern = function(pattern, s) {
    const words = s.split(' ');
    if (pattern.length !== words.length) {
        return false;
    }

    const patternToWord = new Map();
    const wordToPattern = new Map();

    for (let i = 0; i < pattern.length; i++) {
        const char = pattern[i];
        const word = words[i];

        if (!patternToWord.has(char)) {
            patternToWord.set(char, word);
        }

        if (!wordToPattern.has(word)) {
            wordToPattern.set(word, char);
        }

        if (patternToWord.get(char) !== word || wordToPattern.get(word) !== char) {
            return false;
        }
    }

    return true;
};