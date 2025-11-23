var missingRolls = function(rolls, mean, n) {
    const m = rolls.length;
    const totalSum = mean * (m + n);
    const rollsSum = rolls.reduce((a, b) => a + b, 0);
    const missingSum = totalSum - rollsSum;

    if (missingSum < n || missingSum > 6 * n) {
        return [];
    }

    const average = Math.floor(missingSum / n);
    let remainder = missingSum % n;
    const result = new Array(n).fill(average);

    for (let i = 0; i < remainder; i++) {
        result[i]++;
    }

    return result;
};