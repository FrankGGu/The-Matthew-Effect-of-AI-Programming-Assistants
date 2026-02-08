var longestVowelSubsequence = function(word) {
    const vowels = "aeiou";
    let dp = Array(5).fill(0);

    for (let char of word) {
        for (let i = 4; i >= 0; i--) {
            if (char === vowels[i]) {
                if (i === 0) {
                    dp[i] = dp[i] + 1;
                } else {
                    dp[i] = Math.max(dp[i], dp[i - 1] + 1);
                }
            }
        }
    }

    return dp[4];
};