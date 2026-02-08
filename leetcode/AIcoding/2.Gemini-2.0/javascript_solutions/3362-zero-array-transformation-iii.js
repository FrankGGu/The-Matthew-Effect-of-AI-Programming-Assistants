var canTransform = function(nums) {
    let n = nums.length;
    let j = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] !== 0) {
            while (j < n && nums[j] !== 0) {
                j++;
            }
            if (j === n) return false;
            [nums[i], nums[j]] = [nums[j], nums[i]];
        }
    }

    return true;
};