var maximizeSum = function(nums, remove) {
    const n = nums.length;
    if (remove === 0) return nums.reduce((a, b) => a + b, 0);

    nums.sort((a, b) => b - a);
    let sum = 0;
    for (let i = 0; i < remove; i++) {
        nums[i] = 0;
    }
    return nums.reduce((a, b) => a + b, 0);
};