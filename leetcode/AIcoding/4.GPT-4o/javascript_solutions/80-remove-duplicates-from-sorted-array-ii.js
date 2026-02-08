var removeDuplicates = function(nums) {
    if (nums.length <= 2) return nums.length;

    let count = 1, index = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === nums[i - 1]) {
            count++;
            if (count <= 2) {
                nums[index++] = nums[i];
            }
        } else {
            count = 1;
            nums[index++] = nums[i];
        }
    }
    return index;
};