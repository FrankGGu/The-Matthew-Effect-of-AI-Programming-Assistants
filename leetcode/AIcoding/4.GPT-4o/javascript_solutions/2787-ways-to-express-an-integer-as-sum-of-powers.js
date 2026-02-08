var numberOfWays = function(n, x) {
    const memo = new Map();

    const dfs = (num, exp) => {
        if (num === 0) return 1;
        if (num < 0 || exp <= 0) return 0;
        const key = `${num}-${exp}`;
        if (memo.has(key)) return memo.get(key);

        const power = Math.pow(exp, x);
        const result = dfs(num - power, exp - 1) + dfs(num, exp - 1);
        memo.set(key, result);
        return result;
    };

    return dfs(n, Math.floor(Math.pow(n, 1 / x)));
};