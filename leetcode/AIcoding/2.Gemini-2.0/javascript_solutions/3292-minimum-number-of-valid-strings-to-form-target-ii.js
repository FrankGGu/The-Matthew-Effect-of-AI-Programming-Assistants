var minStickers = function(words, target) {
    const n = target.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i <= n; i++) {
        if (dp[i] === Infinity) continue;

        for (const word of words) {
            let j = i;
            let k = 0;
            let newIndex = i;

            while (j < n && k < word.length) {
                if (target[j] === word[k]) {
                    j++;
                    k++;
                } else {
                    k++;
                }
            }

            newIndex = Math.max(newIndex, j);
            dp[newIndex] = Math.min(dp[newIndex], dp[i] + 1);
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};