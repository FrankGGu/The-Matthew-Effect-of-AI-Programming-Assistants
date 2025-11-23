var findKDistantIndices = function(nums, key, k) {
    const result = [];
    const keyIndices = [];

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === key) {
            keyIndices.push(i);
        }
    }

    for (let i = 0; i < nums.length; i++) {
        for (const j of keyIndices) {
            if (Math.abs(i - j) <= k) {
                result.push(i);
                break;
            }
        }
    }

    return result;
};