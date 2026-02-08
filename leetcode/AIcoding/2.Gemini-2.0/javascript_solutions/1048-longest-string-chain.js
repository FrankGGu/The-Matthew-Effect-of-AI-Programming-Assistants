var longestStrChain = function(words) {
    words.sort((a, b) => a.length - b.length);
    const dp = new Map();
    let maxChainLength = 0;

    for (const word of words) {
        let currentChainLength = 1;
        for (let i = 0; i < word.length; i++) {
            const predecessor = word.substring(0, i) + word.substring(i + 1);
            if (dp.has(predecessor)) {
                currentChainLength = Math.max(currentChainLength, dp.get(predecessor) + 1);
            }
        }
        dp.set(word, currentChainLength);
        maxChainLength = Math.max(maxChainLength, currentChainLength);
    }

    return maxChainLength;
};