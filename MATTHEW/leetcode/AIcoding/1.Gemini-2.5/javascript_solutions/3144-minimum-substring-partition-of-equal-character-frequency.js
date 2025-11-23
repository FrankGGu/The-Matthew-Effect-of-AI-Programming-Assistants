var minimumSubstringsInPartition = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        const charCounts = new Array(26).fill(0);
        for (let j = i - 1; j >= 0; j--) {
            const charCode = s.charCodeAt(j) - 'a'.charCodeAt(0);
            charCounts[charCode]++;

            let firstFreq = -1;
            let isValid = true;
            for (let k = 0; k < 26; k++) {
                if (charCounts[k] > 0) {
                    if (firstFreq === -1) {
                        firstFreq = charCounts[k];
                    } else if (charCounts[k] !== firstFreq) {
                        isValid = false;
                        break;
                    }
                }
            }

            if (isValid) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n];
};