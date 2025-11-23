var minCostToEqualizeArray = function(nums, cost1, cost2) {
    const MOD = 1e9 + 7;
    const maxNum = Math.max(...nums);
    let total = 0;
    let sum = 0;
    for (const num of nums) {
        const diff = maxNum - num;
        total += diff;
        sum += diff * diff;
    }

    if (cost1 * 2 <= cost2) {
        return (total * cost1) % MOD;
    }

    let res = Infinity;
    const maxPossible = maxNum + 2 * Math.sqrt(sum) + 2;

    for (let target = maxNum; target <= maxPossible; target++) {
        let currentTotal = 0;
        let currentSum = 0;
        for (const num of nums) {
            const diff = target - num;
            currentTotal += diff;
            currentSum += diff * diff;
        }

        if (currentTotal === 0) {
            res = Math.min(res, 0);
            continue;
        }

        const pairs = Math.floor(currentTotal / 2);
        const remaining = currentTotal % 2;
        const cost = Math.min(pairs * cost2 + remaining * cost1, currentTotal * cost1);
        res = Math.min(res, cost);
    }

    return res % MOD;
};