var longestSubarray = function(nums) {
    let left = 0;
    let zeros = 0;
    let maxLen = 0;

    for (let right = 0; right < nums.length; right++) {
        if (nums[right] === 0) {
            zeros++;
        }

        while (zeros > 1) {
            if (nums[left] === 0) {
                zeros--;
            }
            left++;
        }

        // The length of the current window of 1s after deleting one element.
        // If zeros is 0, we have 'right - left + 1' ones, delete one, get 'right - left' ones.
        // If zeros is 1, we have 'right - left' ones and one zero, delete the zero, get 'right - left' ones.
        maxLen = Math.max(maxLen, right - left);
    }

    return maxLen;
};