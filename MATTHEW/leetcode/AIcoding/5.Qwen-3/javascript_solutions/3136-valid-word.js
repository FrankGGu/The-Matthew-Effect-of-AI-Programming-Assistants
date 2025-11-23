function isValidWord(word) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let vowelCount = 0;
    let consonantCount = 0;
    for (let char of word.toLowerCase()) {
        if (char >= 'a' && char <= 'z') {
            if (vowels.has(char)) {
                vowelCount++;
            } else {
                consonantCount++;
            }
        }
    }
    return vowelCount > 0 && consonantCount > 0;
}