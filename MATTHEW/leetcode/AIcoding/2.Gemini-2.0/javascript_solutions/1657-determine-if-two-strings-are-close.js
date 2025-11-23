var closeStrings = function(word1, word2) {
    if (word1.length !== word2.length) return false;

    const freq1 = new Array(26).fill(0);
    const freq2 = new Array(26).fill(0);

    for (const char of word1) {
        freq1[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const char of word2) {
        freq2[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if ((freq1[i] === 0 && freq2[i] !== 0) || (freq1[i] !== 0 && freq2[i] === 0)) {
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