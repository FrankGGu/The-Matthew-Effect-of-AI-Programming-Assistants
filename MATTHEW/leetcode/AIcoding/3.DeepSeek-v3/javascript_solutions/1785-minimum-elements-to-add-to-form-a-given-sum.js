var minElements = function(nums, limit, goal) {
    const sum = nums.reduce((a, b) => a + b, 0);
    const diff = Math.abs(goal - sum);
    return Math.ceil(diff / limit);
};