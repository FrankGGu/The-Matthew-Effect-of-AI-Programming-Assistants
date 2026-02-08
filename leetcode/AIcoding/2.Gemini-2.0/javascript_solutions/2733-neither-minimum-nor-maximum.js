var findNonMinOrMax = function(nums) {
    if (nums.length <= 2) return -1;

    const sorted = [...nums].sort((a, b) => a - b);
    return sorted[1];
};