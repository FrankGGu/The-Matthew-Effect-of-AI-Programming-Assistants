var numsSameConsecDiff = function(N, K) {
    if (N === 1) return Array.from({length: 10}, (_, i) => i);

    const result = [];

    const dfs = (num, length) => {
        if (length === N) {
            result.push(num);
            return;
        }

        const lastDigit = num % 10;

        if (lastDigit + K < 10) {
            dfs(num * 10 + (lastDigit + K), length + 1);
        }
        if (K > 0 && lastDigit - K >= 0) {
            dfs(num * 10 + (lastDigit - K), length + 1);
        }
    };

    for (let i = 1; i < 10; i++) {
        dfs(i, 1);
    }

    return result;
};