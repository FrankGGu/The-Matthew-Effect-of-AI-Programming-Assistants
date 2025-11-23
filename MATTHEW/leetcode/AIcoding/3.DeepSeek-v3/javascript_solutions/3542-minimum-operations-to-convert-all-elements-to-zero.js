var minimumOperations = function(nums) {
    let count = 0;
    let sum = 0;
    nums.sort((a, b) => a - b);
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > sum) {
            count++;
            sum += nums[i] - sum;
        }
    }
    return count;
};