var minimumArraySum = function(nums) {
    nums.sort((a, b) => a - b);
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum = Math.max(sum + nums[i], nums[i]);
    }
    return sum;
};