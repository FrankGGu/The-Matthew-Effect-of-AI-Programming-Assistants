var totalHammingDistance = function(nums) {
    let total = 0;
    const n = nums.length;

    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (nums[j] & (1 << i)) count++;
        }
        total += count * (n - count);
    }

    return total;
};