var rangeSum = function(nums, n, left, right) {
    const allSubarraySums = [];
    for (let i = 0; i < n; i++) {
        let currentSum = 0;
        for (let j = i; j < n; j++) {
            currentSum += nums[j];
            allSubarraySums.push(currentSum);
        }
    }

    allSubarraySums.sort((a, b) => a - b);

    let totalRangeSum = 0;
    const MOD = 10**9 + 7;

    for (let k = left - 1; k < right; k++) {
        totalRangeSum = (totalRangeSum + allSubarraySums[k]) % MOD;
    }

    return totalRangeSum;
};