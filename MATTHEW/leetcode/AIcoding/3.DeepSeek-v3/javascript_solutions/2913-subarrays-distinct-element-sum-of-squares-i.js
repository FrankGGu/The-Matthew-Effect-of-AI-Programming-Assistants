var sumCounts = function(nums) {
    let total = 0;
    for (let i = 0; i < nums.length; i++) {
        let distinct = new Set();
        for (let j = i; j < nums.length; j++) {
            distinct.add(nums[j]);
            total += distinct.size * distinct.size;
        }
    }
    return total;
};