var checkIfPangram = function(sentence) {
    const seen = new Set();
    for (let i = 0; i < sentence.length; i++) {
        seen.add(sentence[i]);
    }
    return seen.size === 26;
};