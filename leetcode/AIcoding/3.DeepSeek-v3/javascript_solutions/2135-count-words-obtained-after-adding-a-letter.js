var wordCount = function(startWords, targetWords) {
    const seen = new Set();
    for (const word of startWords) {
        const mask = getMask(word);
        for (let i = 0; i < 26; i++) {
            if ((mask & (1 << i)) === 0) {
                seen.add(mask | (1 << i));
            }
        }
    }

    let count = 0;
    for (const word of targetWords) {
        const mask = getMask(word);
        if (seen.has(mask)) {
            count++;
        }
    }
    return count;
};

function getMask(word) {
    let mask = 0;
    for (const ch of word) {
        mask |= 1 << (ch.charCodeAt(0) - 'a'.charCodeAt(0));
    }
    return mask;
}