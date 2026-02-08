var findLength = function(nums, k) {
    let maxLen = 0;
    let count = {};
    let left = 0;
    let maxFreq = 0;

    for (let right = 0; right < nums.length; right++) {
        if (!count[nums[right]]) {
            count[nums[right]] = 0;
        }
        count[nums[right]]++;
        maxFreq = Math.max(maxFreq, count[nums[right]]);

        while (right - left + 1 - maxFreq > k) {
            count[nums[left]]--;
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};