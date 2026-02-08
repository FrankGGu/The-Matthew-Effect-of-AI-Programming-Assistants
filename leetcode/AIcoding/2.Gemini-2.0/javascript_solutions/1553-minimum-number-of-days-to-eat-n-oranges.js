var minDays = function(n) {
    const memo = new Map();

    function dp(remaining) {
        if (remaining <= 1) {
            return remaining;
        }

        if (memo.has(remaining)) {
            return memo.get(remaining);
        }

        let days = Math.min(
            remaining % 2 + 1 + dp(remaining / 2),
            remaining % 3 + 1 + dp(remaining / 3)
        );

        memo.set(remaining, days);
        return days;
    }

    return dp(n);
};