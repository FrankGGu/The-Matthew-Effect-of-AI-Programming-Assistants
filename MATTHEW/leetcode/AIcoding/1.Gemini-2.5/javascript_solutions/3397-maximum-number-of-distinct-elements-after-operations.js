var maximumDistinctElements = function(nums) {
    const n = nums.length;
    if (n % 2 === 1) {
        return n;
    } else {
        return n - 1;
    }
};