var minPatches = function(nums, n) {
    let patches = 0;
    let reach = 0;
    let i = 0;

    while (reach < n) {
        if (i < nums.length && nums[i] <= reach + 1) {
            reach += nums[i];
            i++;
        } else {
            reach += reach + 1;
            patches++;
        }
    }

    return patches;
};