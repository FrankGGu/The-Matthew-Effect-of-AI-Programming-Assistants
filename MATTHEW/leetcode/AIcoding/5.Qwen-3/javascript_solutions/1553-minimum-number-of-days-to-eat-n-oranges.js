var minDays = function(n) {
    const memo = {};

    const dfs = (n) => {
        if (n <= 1) return n;
        if (memo[n] !== undefined) return memo[n];

        const option1 = 1 + dfs(Math.floor(n / 2));
        const option2 = 1 + dfs(Math.floor(n / 3));

        memo[n] = Math.min(option1, option2);
        return memo[n];
    };

    return dfs(n);
};