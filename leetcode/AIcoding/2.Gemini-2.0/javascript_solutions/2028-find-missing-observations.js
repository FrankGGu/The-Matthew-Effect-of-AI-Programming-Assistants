var missingRolls = function(rolls, mean, n) {
    const m = rolls.length;
    const sumRolls = rolls.reduce((acc, curr) => acc + curr, 0);
    const missingSum = mean * (n + m) - sumRolls;

    if (missingSum < n || missingSum > 6 * n) {
        return [];
    }

    const missing = [];
    const base = Math.floor(missingSum / n);
    const remainder = missingSum % n;

    for (let i = 0; i < n; i++) {
        missing.push(base + (i < remainder ? 1 : 0));
    }

    return missing;
};