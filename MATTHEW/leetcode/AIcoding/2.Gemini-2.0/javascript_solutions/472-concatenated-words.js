var findAllConcatenatedWordsInADict = function(words) {
    const wordSet = new Set(words);
    const result = [];

    function canForm(word) {
        if (wordSet.has(word) && wordSet.size === 1 && wordSet.has(words[0])) return false;
        const n = word.length;
        const dp = new Array(n + 1).fill(false);
        dp[0] = true;

        for (let i = 1; i <= n; i++) {
            for (let j = 0; j < i; j++) {
                if (dp[j] && wordSet.has(word.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }

        return dp[n];
    }

    for (const word of words) {
        if (canForm(word)) {
            result.push(word);
        }
    }

    return result;
};