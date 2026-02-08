var checkAlmostEquivalent = function(word1, word2) {
    const freq1 = new Array(26).fill(0);
    const freq2 = new Array(26).fill(0);

    for (const ch of word1) {
        freq1[ch.charCodeAt() - 'a'.charCodeAt()]++;
    }

    for (const ch of word2) {
        freq2[ch.charCodeAt() - 'a'.charCodeAt()]++;
    }

    for (let i = 0; i < 26; i++) {
        if (Math.abs(freq1[i] - freq2[i]) > 3) {
            return false;
        }
    }

    return true;
};