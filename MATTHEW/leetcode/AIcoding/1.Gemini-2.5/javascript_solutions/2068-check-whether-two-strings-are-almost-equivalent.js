var checkAlmostEquivalent = function(word1, word2) {
    const freq1 = new Array(26).fill(0);
    const freq2 = new Array(26).fill(0);

    for (let i = 0; i < word1.length; i++) {
        freq1[word1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        freq2[word2.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if (Math.abs(freq1[i] - freq2[i]) > 3) {
            return false;
        }
    }

    return true;
};