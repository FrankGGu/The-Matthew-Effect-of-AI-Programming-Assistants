var partitionArray = function(nums, k) {
    nums.sort((a, b) => a - b);

    let count = 1;
    let minVal = nums[0];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] - minVal > k) {
            count++;
            minVal = nums[i];
        }
    }

    return count;
};