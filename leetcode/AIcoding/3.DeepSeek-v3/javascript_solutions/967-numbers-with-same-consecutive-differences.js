var numsSameConsecDiff = function(n, k) {
    let result = [];

    const dfs = (current, remaining) => {
        if (remaining === 0) {
            result.push(parseInt(current));
            return;
        }

        const lastDigit = parseInt(current[current.length - 1]);
        const nextDigits = new Set();

        if (lastDigit + k <= 9) {
            nextDigits.add(lastDigit + k);
        }
        if (lastDigit - k >= 0) {
            nextDigits.add(lastDigit - k);
        }

        for (const digit of nextDigits) {
            dfs(current + digit, remaining - 1);
        }
    };

    for (let i = 1; i <= 9; i++) {
        dfs(i.toString(), n - 1);
    }

    return result;
};