var minimumCost = function(nums) {
    const first = nums[0];
    const rest = nums.slice(1);
    rest.sort((a, b) => a - b);
    return first + rest[0] + rest[1];
};