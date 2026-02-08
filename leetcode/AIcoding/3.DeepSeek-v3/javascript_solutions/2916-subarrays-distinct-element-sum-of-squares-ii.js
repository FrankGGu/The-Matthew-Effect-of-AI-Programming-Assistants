var sumCounts = function(nums) {
    let total = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        const distinct = new Set();
        for (let j = i; j < n; j++) {
            distinct.add(nums[j]);
            total += distinct.size * distinct.size;
        }
    }
    return total;
};