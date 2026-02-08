var missingRolls = function(rolls, mean, n) {
    const m = rolls.length;
    const sum = rolls.reduce((acc, curr) => acc + curr, 0);
    const missingSum = mean * (n + m) - sum;

    if (missingSum < n || missingSum > 6 * n) {
        return [];
    }

    const base = Math.floor(missingSum / n);
    const remainder = missingSum % n;

    const result = [];
    for (let i = 0; i < n; i++) {
        result.push(base + (i < remainder ? 1 : 0));
    }

    return result;
};