var closeStrings = function(word1, word2) {
    if (word1.length !== word2.length) {
        return false;
    }

    const freq1 = new Array(26).fill(0);
    const freq2 = new Array(26).fill(0);

    for (let i = 0; i < word1.length; i++) {
        freq1[word1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        freq2[word2.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if ((freq1[i] > 0 && freq2[i] === 0) || (freq1[i] === 0 && freq2[i] > 0)) {
            return false;
        }
    }

    freq1.sort((a, b) => a - b);
    freq2.sort((a, b) => a - b);

    for (let i = 0; i < 26; i++) {
        if (freq1[i] !== freq2[i]) {
            return false;
        }
    }

    return true;
};