function maxGridHappiness(m, n, k) {
    const memo = {};
    function getKey(i, j, a, b, c) {
        return `${i},${j},${a},${b},${c}`;
    }

    function dfs(i, j, a, b, c) {
        if (i === m) return 0;
        const key = getKey(i, j, a, b, c);
        if (memo[key] !== undefined) return memo[key];

        let ni = i, nj = j + 1;
        if (nj === n) {
            ni++;
            nj = 0;
        }

        let res = dfs(ni, nj, a, b, c);

        if (c > 0) {
            const val = 0;
            res = Math.max(res, val + dfs(ni, nj, a, b, c - 1));
        }

        if (a > 0 && b > 0) {
            const val = 2;
            res = Math.max(res, val + dfs(ni, nj, a - 1, b - 1, c));
        } else if (a > 0) {
            const val = 1;
            res = Math.max(res, val + dfs(ni, nj, a - 1, b, c));
        } else if (b > 0) {
            const val = 1;
            res = Math.max(res, val + dfs(ni, nj, a, b - 1, c));
        }

        memo[key] = res;
        return res;
    }

    return dfs(0, 0, k, k, 0);
}