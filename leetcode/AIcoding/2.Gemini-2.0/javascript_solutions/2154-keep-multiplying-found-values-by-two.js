var findFinalValue = function(nums, original) {
    let found = true;
    while (found) {
        found = false;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] === original) {
                original *= 2;
                found = true;
                break;
            }
        }
    }
    return original;
};