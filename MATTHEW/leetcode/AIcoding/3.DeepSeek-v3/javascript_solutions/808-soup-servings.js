var soupServings = function(n) {
    if (n >= 5000) return 1.0;
    const memo = new Map();

    const dp = (a, b) => {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1.0;
        if (b <= 0) return 0.0;

        const key = `${a},${b}`;
        if (memo.has(key)) return memo.get(key);

        const prob = 0.25 * (
            dp(a - 100, b) +
            dp(a - 75, b - 25) +
            dp(a - 50, b - 50) +
            dp(a - 25, b - 75)
        );

        memo.set(key, prob);
        return prob;
    };

    return dp(n, n);
};