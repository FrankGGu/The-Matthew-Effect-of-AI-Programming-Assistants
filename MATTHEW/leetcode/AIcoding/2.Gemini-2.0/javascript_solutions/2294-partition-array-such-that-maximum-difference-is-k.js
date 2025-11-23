var partitionArray = function(nums, k) {
    nums.sort((a, b) => a - b);
    let count = 1;
    let currentMin = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] - currentMin > k) {
            count++;
            currentMin = nums[i];
        }
    }
    return count;
};