var maximumScore = function(nums, k) {
    let n = nums.length;
    let left = k, right = k;
    let minVal = nums[k];
    let maxScore = minVal;

    while (left > 0 || right < n - 1) {
        if (right === n - 1 || (left > 0 && nums[left - 1] >= nums[right + 1])) {
            left--;
            minVal = Math.min(minVal, nums[left]);
        } else {
            right++;
            minVal = Math.min(minVal, nums[right]);
        }
        maxScore = Math.max(maxScore, minVal * (right - left + 1));
    }

    return maxScore;
};