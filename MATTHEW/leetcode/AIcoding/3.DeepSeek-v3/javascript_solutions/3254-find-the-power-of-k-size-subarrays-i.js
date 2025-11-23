var sumOfPowers = function(nums, k) {
    let sum = 0;
    const n = nums.length;
    for (let i = 0; i <= n - k; i++) {
        let min = Infinity;
        let max = -Infinity;
        for (let j = i; j < i + k; j++) {
            if (nums[j] < min) min = nums[j];
            if (nums[j] > max) max = nums[j];
        }
        sum += max - min;
    }
    return sum;
};