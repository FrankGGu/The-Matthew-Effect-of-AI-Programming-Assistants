var findAllConcatenatedWordsInADict = function(words) {
    const result = [];
    const wordSet = new Set(words);

    const canConcatenate = (word, currentWordSet) => {
        const n = word.length;
        if (n === 0) {
            return false;
        }

        const dp = new Array(n + 1).fill(Infinity);
        dp[0] = 0;

        for (let i = 1; i <= n; i++) {
            for (let j = 0; j < i; j++) {
                if (dp[j] < Infinity && currentWordSet.has(word.substring(j, i))) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n] >= 2;
    };

    for (const word of words) {
        wordSet.delete(word);

        if (canConcatenate(word, wordSet)) {
            result.push(word);
        }

        wordSet.add(word);
    }

    return result;
};