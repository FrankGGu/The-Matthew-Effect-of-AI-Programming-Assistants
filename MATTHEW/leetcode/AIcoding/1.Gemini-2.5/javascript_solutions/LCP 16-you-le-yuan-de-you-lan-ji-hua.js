var minOperations = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let median = nums[Math.floor((n - 1) / 2)];
    let cost = 0;
    for (let i = 0; i < n; i++) {
        cost += Math.abs(nums[i] - median);
    }
    return cost;
};