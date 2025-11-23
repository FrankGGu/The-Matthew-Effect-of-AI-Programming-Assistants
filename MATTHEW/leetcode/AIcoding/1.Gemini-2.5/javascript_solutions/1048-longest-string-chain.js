var longestStrChain = function(words) {
    words.sort((a, b) => a.length - b.length);

    const dp = new Map();
    let maxChainLength = 0;

    for (const word of words) {
        dp.set(word, 1);
        for (let i = 0; i < word.length; i++) {
            const predecessor = word.substring(0, i) + word.substring(i + 1);
            if (dp.has(predecessor)) {
                dp.set(word, Math.max(dp.get(word), dp.get(predecessor) + 1));
            }
        }
        maxChainLength = Math.max(maxChainLength, dp.get(word));
    }

    return maxChainLength;
};