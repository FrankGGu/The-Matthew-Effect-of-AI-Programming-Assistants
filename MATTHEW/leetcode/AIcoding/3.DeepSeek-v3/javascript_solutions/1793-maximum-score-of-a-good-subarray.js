var maximumScore = function(nums, k) {
    let left = k;
    let right = k;
    let minVal = nums[k];
    let maxScore = minVal;

    while (left > 0 || right < nums.length - 1) {
        if (left === 0) {
            right++;
        } else if (right === nums.length - 1) {
            left--;
        } else if (nums[left - 1] > nums[right + 1]) {
            left--;
        } else {
            right++;
        }
        minVal = Math.min(minVal, Math.min(nums[left], nums[right]));
        maxScore = Math.max(maxScore, minVal * (right - left + 1));
    }
    return maxScore;
};