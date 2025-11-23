function findAllConcatenatedWordsInADict(words) {
    words.sort((a, b) => a.length - b.length);
    const wordSet = new Set(words);
    const result = [];

    function isConcatenated(word, wordSet) {
        const dp = Array(word.length + 1).fill(false);
        dp[0] = true;
        for (let i = 1; i <= word.length; i++) {
            for (let j = 0; j < i; j++) {
                if (dp[j] && wordSet.has(word.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        return dp[word.length];
    }

    for (const word of words) {
        wordSet.delete(word);
        if (isConcatenated(word, wordSet)) {
            result.push(word);
        }
        wordSet.add(word);
    }

    return result;
}