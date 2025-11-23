var closeStrings = function(word1, word2) {
    if (word1.length !== word2.length) return false;

    const freq1 = new Array(26).fill(0);
    const freq2 = new Array(26).fill(0);

    for (const ch of word1) {
        freq1[ch.charCodeAt() - 'a'.charCodeAt()]++;
    }

    for (const ch of word2) {
        const idx = ch.charCodeAt() - 'a'.charCodeAt();
        if (freq1[idx] === 0) return false;
        freq2[idx]++;
    }

    freq1.sort((a, b) => a - b);
    freq2.sort((a, b) => a - b);

    for (let i = 0; i < 26; i++) {
        if (freq1[i] !== freq2[i]) return false;
    }

    return true;
};