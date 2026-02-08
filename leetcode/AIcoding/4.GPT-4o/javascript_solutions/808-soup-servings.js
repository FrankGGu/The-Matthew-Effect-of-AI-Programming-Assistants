var soupServings = function(N) {
    if (N > 5000) return 1;
    const memo = new Map();

    const dfs = (a, b) => {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1;
        if (b <= 0) return 0;
        const key = `${a},${b}`;
        if (memo.has(key)) return memo.get(key);

        const result = 0.25 * (dfs(a - 100, b) + dfs(a - 75, b - 25) + dfs(a - 50, b - 50) + dfs(a - 25, b - 75));
        memo.set(key, result);
        return result;
    };

    return dfs(N, N);
};