function maxNonOverlappingSubstrings(s, chars) {
    const map = new Map();
    for (const c of chars) {
        map.set(c, []);
    }
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (const [c, list] of map.entries()) {
            if (i - 1 >= 0 && s[i - 1] === c) {
                for (const j of list) {
                    if (j >= 0) {
                        dp[i] = Math.max(dp[i], dp[j] + 1);
                    }
                }
            }
        }
        for (const [c, list] of map.entries()) {
            if (s[i - 1] === c) {
                list.push(i - 1);
            }
        }
    }
    return dp[n];
}