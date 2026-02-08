var totalHammingDistance = function(nums) {
    let n = nums.length;
    let total = 0;
    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if ((nums[j] >> i) & 1) {
                count++;
            }
        }
        total += count * (n - count);
    }
    return total;
};