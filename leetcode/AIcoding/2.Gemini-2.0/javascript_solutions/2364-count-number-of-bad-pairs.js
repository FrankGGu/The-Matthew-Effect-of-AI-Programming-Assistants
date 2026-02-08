var countBadPairs = function(nums) {
    let count = 0;
    let n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (nums[j] - nums[i] !== j - i) {
                count++;
            }
        }
    }
    return count;
};