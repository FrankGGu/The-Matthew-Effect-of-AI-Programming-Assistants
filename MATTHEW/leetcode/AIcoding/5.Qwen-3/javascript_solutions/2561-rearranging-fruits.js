function minCostToRearrangeAlphabets(s) {
    const count = {};
    for (const c of s) {
        count[c] = (count[c] || 0) + 1;
    }

    const keys = Object.keys(count);
    const n = keys.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                const nextMask = mask | (1 << i);
                const currentChar = keys[i];
                const currentCount = count[currentChar];
                let cost = 0;
                let pos = 0;
                for (let j = 0; j < s.length; j++) {
                    if (s[j] === currentChar) {
                        cost += Math.abs(j - pos);
                        pos++;
                    }
                }
                dp[nextMask] = Math.min(dp[nextMask], dp[mask] + cost);
            }
        }
    }

    return dp[(1 << n) - 1];
}