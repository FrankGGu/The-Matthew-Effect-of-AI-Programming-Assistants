var find132pattern = function(nums) {
    if (nums.length < 3) return false;
    let min_i = nums[0];
    for (let j = 1; j < nums.length - 1; j++) {
        min_i = Math.min(min_i, nums[j - 1]);
        for (let k = j + 1; k < nums.length; k++) {
            if (nums[k] > min_i && nums[k] < nums[j]) {
                return true;
            }
        }
    }
    return false;
};