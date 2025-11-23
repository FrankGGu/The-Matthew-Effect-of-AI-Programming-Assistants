var findFinalValue = function(nums) {
    const set = new Set(nums);
    let value = 1;
    while (set.has(value)) {
        value++;
    }
    return value;
};