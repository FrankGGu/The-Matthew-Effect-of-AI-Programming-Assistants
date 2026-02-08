var findKDistantIndices = function(nums, key, k) {
    const result = [];
    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < nums.length; j++) {
            if (nums[j] === key && Math.abs(i - j) <= k) {
                result.push(i);
                break;
            }
        }
    }
    return result;
};