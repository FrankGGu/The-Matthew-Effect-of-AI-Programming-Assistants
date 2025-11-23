var numberGame = function(nums) {
    const result = [];
    nums.sort((a, b) => a - b);
    for (let i = 0; i < nums.length; i += 2) {
        result.push(nums[i+1]);
        result.push(nums[i]);
    }
    return result;
};