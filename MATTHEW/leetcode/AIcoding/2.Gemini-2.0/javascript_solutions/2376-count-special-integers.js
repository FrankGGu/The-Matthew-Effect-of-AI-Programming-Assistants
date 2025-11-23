var countSpecialNumbers = function(n) {
    const s = n.toString();
    const m = s.length;
    let memo = Array(m).fill(null).map(() => Array(1 << 10).fill(null));

    function dfs(i, mask, isLimit, isNum) {
        if (i === m) {
            return isNum ? 1 : 0;
        }

        if (!isLimit && isNum && memo[i][mask] !== null) {
            return memo[i][mask];
        }

        let res = 0;
        if (!isNum) {
            res += dfs(i + 1, mask, false, false);
        }

        let up = isLimit ? parseInt(s[i]) : 9;
        let start = isNum ? 0 : 1;

        for (let d = start; d <= up; d++) {
            if ((mask & (1 << d)) === 0) {
                res += dfs(i + 1, mask | (1 << d), isLimit && d === up, true);
            }
        }

        if (!isLimit && isNum) {
            memo[i][mask] = res;
        }

        return res;
    }

    return dfs(0, 0, true, false);
};