var missingNumber = function(nums) {
    const n = nums.length;
    const total = (n * (n + 1)) / 2;
    const sum = nums.reduce((acc, num) => acc + num, 0);
    return total - sum;
};