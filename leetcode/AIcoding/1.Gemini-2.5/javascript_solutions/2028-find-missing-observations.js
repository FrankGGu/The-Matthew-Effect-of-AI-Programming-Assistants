var missingRolls = function(rolls, mean, n) {
    const m = rolls.length;
    let sumRolls = 0;
    for (let i = 0; i < m; i++) {
        sumRolls += rolls[i];
    }

    const totalObservations = m + n;
    const targetTotalSum = totalObservations * mean;
    const targetSumMissing = targetTotalSum - sumRolls;

    if (targetSumMissing < n * 1 || targetSumMissing > n * 6) {
        return [];
    }

    const result = new Array(n);
    const baseValue = Math.floor(targetSumMissing / n);
    let remainder = targetSumMissing % n;

    for (let i = 0; i < n; i++) {
        if (remainder > 0) {
            result[i] = baseValue + 1;
            remainder--;
        } else {
            result[i] = baseValue;
        }
    }

    return result;
};