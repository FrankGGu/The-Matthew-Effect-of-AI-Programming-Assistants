var alternatingSubarray = function(nums) {
    let maxLen = -1;
    for (let i = 0; i < nums.length - 1; i++) {
        if (Math.abs(nums[i + 1] - nums[i]) === 1) {
            if (nums[i + 1] - nums[i] === 1) {
                let len = 2;
                let expectedDiff = -1;
                for (let j = i + 2; j < nums.length; j++) {
                    if (nums[j] - nums[j - 1] === expectedDiff) {
                        len++;
                        expectedDiff = -expectedDiff;
                    } else {
                        break;
                    }
                }
                maxLen = Math.max(maxLen, len);
            }
        }
    }
    return maxLen;
};