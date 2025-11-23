function wordPattern(pattern, s) {
    const words = s.split(' ');
    if (pattern.length !== words.length) return false;
    const charToWord = {};
    const wordToChar = {};
    for (let i = 0; i < pattern.length; i++) {
        const char = pattern[i];
        const word = words[i];
        if (charToWord[char] && charToWord[char] !== word) return false;
        if (wordToChar[word] && wordToChar[word] !== char) return false;
        charToWord[char] = word;
        wordToChar[word] = char;
    }
    return true;
}