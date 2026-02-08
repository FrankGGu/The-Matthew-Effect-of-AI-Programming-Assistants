var findInteger = function(nums, k) {
    nums.sort((a, b) => a - b);
    let count = 0;
    let i = 0;
    while (count < k) {
        if (i < nums.length && count + 1 >= nums[i]) {
            count = nums[i];
            i++;
        } else {
            count++;
        }
    }
    return count;
};