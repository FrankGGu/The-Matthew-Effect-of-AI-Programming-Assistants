var longestStrChain = function(words) {
    const dp = new Map();
    words.sort((a, b) => a.length - b.length);
    let maxChainLength = 1;

    for (const word of words) {
        dp.set(word, 1);
        for (let i = 0; i < word.length; i++) {
            const predecessor = word.slice(0, i) + word.slice(i + 1);
            if (dp.has(predecessor)) {
                dp.set(word, Math.max(dp.get(word), dp.get(predecessor) + 1));
            }
        }
        maxChainLength = Math.max(maxChainLength, dp.get(word));
    }

    return maxChainLength;
};