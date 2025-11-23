var rangeSum = function(nums, n, left, right) {
    const sums = [];
    for (let i = 0; i < n; i++) {
        let currentSum = 0;
        for (let j = i; j < n; j++) {
            currentSum += nums[j];
            sums.push(currentSum);
        }
    }
    sums.sort((a, b) => a - b);
    let total = 0;
    for (let i = left - 1; i < right; i++) {
        total = (total + sums[i]) % (10**9 + 7);
    }
    return total;
};