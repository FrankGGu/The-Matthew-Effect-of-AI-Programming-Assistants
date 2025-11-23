var countMatchingSubarrays = function(nums, pattern) {
    const m = nums.length;
    const n = pattern.length;
    let count = 0;

    if (n > m - 1) {
        return 0;
    }

    for (let i = 0; i <= m - n - 1; i++) {
        let match = true;
        for (let j = 0; j < n; j++) {
            if ((nums[i + j + 1] - nums[i + j] > 0 && pattern[j] !== 1) ||
                (nums[i + j + 1] - nums[i + j] < 0 && pattern[j] !== -1) ||
                (nums[i + j + 1] - nums[i + j] === 0 && pattern[j] !== 0)) {
                match = false;
                break;
            }
        }
        if (match) {
            count++;
        }
    }

    return count;
};