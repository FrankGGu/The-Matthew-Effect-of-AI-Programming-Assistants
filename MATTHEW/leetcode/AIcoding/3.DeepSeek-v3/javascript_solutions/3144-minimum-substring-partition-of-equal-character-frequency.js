var minimumSubstringsInPartition = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        const freq = new Array(26).fill(0);
        for (let j = i; j >= 1; j--) {
            const c = s.charCodeAt(j - 1) - 97;
            freq[c]++;
            let maxFreq = 0;
            let minFreq = Infinity;
            let isValid = true;
            for (let k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    maxFreq = Math.max(maxFreq, freq[k]);
                    minFreq = Math.min(minFreq, freq[k]);
                }
            }
            if (maxFreq !== minFreq) {
                isValid = false;
            }
            if (isValid) {
                dp[i] = Math.min(dp[i], dp[j - 1] + 1);
            }
        }
    }

    return dp[n];
};