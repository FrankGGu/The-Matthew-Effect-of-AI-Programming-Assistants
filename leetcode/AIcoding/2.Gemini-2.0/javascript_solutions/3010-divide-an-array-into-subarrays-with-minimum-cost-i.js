var divideArray = function(nums, k) {
    nums.sort((a, b) => a - b);
    let cost = nums[0];
    for (let i = 1; i < k; i++) {
        cost += nums[i];
    }
    return cost;
};