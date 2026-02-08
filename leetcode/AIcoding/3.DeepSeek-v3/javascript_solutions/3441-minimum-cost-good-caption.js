var minimumCost = function(sentence, k) {
    const words = sentence.split(' ');
    const n = words.length;
    const dp = new Array(n).fill(Infinity);

    for (let i = 0; i < n; i++) {
        let len = 0;
        for (let j = i; j >= 0; j--) {
            len += words[j].length;
            if (len > k) break;
            const cost = j === 0 ? 0 : dp[j - 1];
            const currentCost = (k - len) * (k - len);
            dp[i] = Math.min(dp[i], cost + currentCost);
            len += 1;
        }
    }

    return dp[n - 1];
};