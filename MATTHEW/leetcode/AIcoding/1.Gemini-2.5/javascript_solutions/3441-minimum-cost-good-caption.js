var minimumCostGoodCaption = function(words, costs, targetWidth) {
    const n = words.length;
    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        let currentLineCost = 0;
        let currentLineWidth = 0;
        for (let j = i; j < n; j++) {
            const wordLength = words[j].length;
            const wordCost = costs[j];

            if (j > i) {
                currentLineWidth += 1; // space
            }
            currentLineWidth += wordLength;
            currentLineCost = Math.max(currentLineCost, wordCost);

            if (currentLineWidth <= targetWidth) {
                dp[j + 1] = Math.min(dp[j + 1], dp[i] + currentLineCost);
            } else {
                break;
            }
        }
    }

    return dp[n];
};