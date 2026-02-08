var longestOnes = function(nums, k) {
    let left = 0, right = 0;
    let maxLength = 0;
    let zeroCount = 0;

    while (right < nums.length) {
        if (nums[right] === 0) {
            zeroCount++;
        }

        while (zeroCount > k) {
            if (nums[left] === 0) {
                zeroCount--;
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};