var countMatchingSubarrays = function(nums, pattern) {
    let count = 0;
    for (let i = 0; i <= nums.length - pattern.length - 1; i++) {
        let match = true;
        for (let j = 0; j < pattern.length; j++) {
            if ((nums[i + j + 1] > nums[i + j] && pattern[j] !== 1) ||
                (nums[i + j + 1] < nums[i + j] && pattern[j] !== -1) ||
                (nums[i + j + 1] === nums[i + j] && pattern[j] !== 0)) {
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