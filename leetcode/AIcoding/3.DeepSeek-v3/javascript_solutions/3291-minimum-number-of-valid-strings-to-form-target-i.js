var minimumSubstringsInPartition = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        const count = new Array(26).fill(0);
        for (let j = i; j >= 1; j--) {
            const char = s[j - 1];
            count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            let maxFreq = 0;
            let allSame = true;
            for (let k = 0; k < 26; k++) {
                if (count[k] > 0) {
                    if (maxFreq === 0) {
                        maxFreq = count[k];
                    } else if (count[k] !== maxFreq) {
                        allSame = false;
                        break;
                    }
                }
            }
            if (allSame) {
                dp[i] = Math.min(dp[i], dp[j - 1] + 1);
            }
        }
    }

    return dp[n];
};