var minDays = function(n) {
    const memo = new Map();

    const dp = (num) => {
        if (num <= 1) return num;
        if (memo.has(num)) return memo.get(num);

        let res = 1 + Math.min(
            num % 2 + dp(Math.floor(num / 2)),
            num % 3 + dp(Math.floor(num / 3))
        );
        memo.set(num, res);
        return res;
    };

    return dp(n);
};