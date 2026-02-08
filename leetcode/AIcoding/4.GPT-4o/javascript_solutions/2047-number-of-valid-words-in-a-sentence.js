var countValidWords = function(sentence) {
    const words = sentence.split(' ');
    let validCount = 0;

    for (const word of words) {
        if (word.length === 0) continue;
        const hasHyphen = word.includes('-');
        const hasDigit = /\d/.test(word);
        const hasPunctuation = /[!.,]/.test(word[word.length - 1]);

        if (hasDigit) continue;

        if (hasHyphen) {
            const parts = word.split('-');
            if (parts.length !== 2 || parts[0].length === 0 || parts[1].length === 0 || parts.some(p => /[!.,]/.test(p))) continue;
        }

        if (hasPunctuation && word.length === 1) continue;

        validCount++;
    }

    return validCount;
};