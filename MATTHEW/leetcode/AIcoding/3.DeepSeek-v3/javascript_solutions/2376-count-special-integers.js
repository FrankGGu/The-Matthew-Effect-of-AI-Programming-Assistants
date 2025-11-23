var countSpecialNumbers = function(n) {
    const s = n.toString();
    const m = s.length;
    const memo = new Array(m).fill().map(() => new Array(1 << 10).fill(-1));

    function dp(pos, mask, isLimit, isNum) {
        if (pos === m) {
            return isNum ? 1 : 0;
        }
        if (!isLimit && isNum && memo[pos][mask] !== -1) {
            return memo[pos][mask];
        }
        let res = 0;
        if (!isNum) {
            res = dp(pos + 1, mask, false, false);
        }
        const up = isLimit ? parseInt(s[pos]) : 9;
        const start = isNum ? 0 : 1;
        for (let d = start; d <= up; d++) {
            if ((mask & (1 << d)) === 0) {
                res += dp(pos + 1, mask | (1 << d), isLimit && (d === up), true);
            }
        }
        if (!isLimit && isNum) {
            memo[pos][mask] = res;
        }
        return res;
    }

    return dp(0, 0, true, false);
};