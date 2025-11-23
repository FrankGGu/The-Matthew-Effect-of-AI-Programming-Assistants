var findFinalValue = function(nums, original) {
    let current = original;
    while (nums.includes(current)) {
        current *= 2;
    }
    return current;
};