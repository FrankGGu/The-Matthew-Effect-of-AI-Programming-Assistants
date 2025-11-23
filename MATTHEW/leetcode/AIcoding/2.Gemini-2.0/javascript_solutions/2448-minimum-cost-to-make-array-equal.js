var minCost = function(nums) {
    nums.sort((a, b) => a - b);
    let mid = nums[Math.floor(nums.length / 2)];
    let cost = 0;
    for (let i = 0; i < nums.length; i++) {
        cost += Math.abs(nums[i] - mid);
    }
    return cost;
};