var minPatches = function(nums, n) {
    let patches = 0;
    let miss = 1;
    let i = 0;
    const len = nums.length;

    while (miss <= n) {
        if (i < len && nums[i] <= miss) {
            miss += nums[i];
            i++;
        } else {
            miss += miss;
            patches++;
        }
    }

    return patches;
};