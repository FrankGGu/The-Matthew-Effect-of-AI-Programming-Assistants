var minPatches = function(nums, n) {
    let patches = 0, i = 0, x = 1;
    while (x <= n) {
        if (i < nums.length && nums[i] <= x) {
            x += nums[i];
            i++;
        } else {
            x += x;
            patches++;
        }
    }
    return patches;
};