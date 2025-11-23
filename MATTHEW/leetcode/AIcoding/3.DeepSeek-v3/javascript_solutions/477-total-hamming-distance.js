var totalHammingDistance = function(nums) {
    let total = 0;
    const n = nums.length;
    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (const num of nums) {
            count += (num >> i) & 1;
        }
        total += count * (n - count);
    }
    return total;
};