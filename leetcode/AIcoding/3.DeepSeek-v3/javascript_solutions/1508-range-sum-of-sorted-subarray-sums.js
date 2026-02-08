var rangeSum = function(nums, n, left, right) {
    let subarraySums = [];
    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = i; j < n; j++) {
            sum += nums[j];
            subarraySums.push(sum);
        }
    }
    subarraySums.sort((a, b) => a - b);
    let result = 0;
    const MOD = 1e9 + 7;
    for (let i = left - 1; i < right; i++) {
        result = (result + subarraySums[i]) % MOD;
    }
    return result;
};