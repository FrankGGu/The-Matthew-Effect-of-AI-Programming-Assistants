var countIncreasingSubarrays = function(nums, k) {
    let count = 0;
    let len = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            len++;
        } else {
            len = 1;
        }
        if (len >= k) {
            count += (len - k + 1);
        }
    }
    return count;
};