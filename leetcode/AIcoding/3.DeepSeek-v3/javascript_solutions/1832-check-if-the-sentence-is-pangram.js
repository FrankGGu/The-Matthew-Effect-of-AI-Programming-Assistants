var checkIfPangram = function(sentence) {
    const alphabet = new Set();
    for (const char of sentence) {
        if (char >= 'a' && char <= 'z') {
            alphabet.add(char);
        }
    }
    return alphabet.size === 26;
};