var partitionArray = function(nums, k) {
    nums.sort((a, b) => a - b);
    let partitions = 1;
    let start = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] - start > k) {
            partitions++;
            start = nums[i];
        }
    }
    return partitions;
};