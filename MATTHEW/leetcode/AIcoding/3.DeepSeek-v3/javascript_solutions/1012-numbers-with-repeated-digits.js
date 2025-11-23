var numDupDigitsAtMostN = function(n) {
    const s = n.toString();
    const k = s.length;
    const memo = new Array(k);
    for (let i = 0; i < k; i++) {
        memo[i] = new Array(1 << 10).fill(-1);
    }

    function dp(i, mask, isTight, isLeading) {
        if (i === k) return isLeading ? 0 : 1;
        if (!isTight && !isLeading && memo[i][mask] !== -1) return memo[i][mask];

        let res = 0;
        const limit = isTight ? parseInt(s[i]) : 9;
        for (let d = 0; d <= limit; d++) {
            const newTight = isTight && (d === limit);
            const newLeading = isLeading && (d === 0);
            if (newLeading) {
                res += dp(i + 1, mask, newTight, newLeading);
            } else {
                if ((mask & (1 << d)) === 0) {
                    res += dp(i + 1, mask | (1 << d), newTight, newLeading);
                }
            }
        }

        if (!isTight && !isLeading) memo[i][mask] = res;
        return res;
    }

    return n - dp(0, 0, true, true);
};