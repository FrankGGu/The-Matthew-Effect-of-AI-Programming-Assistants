var maximumScore = function(nums, k) {
    const n = nums.length;
    let left = k;
    let right = k;
    let minVal = nums[k];
    let maxScore = nums[k];

    while (left > 0 || right < n - 1) {
        if (left === 0) {
            right++;
        } else if (right === n - 1) {
            left--;
        } else if (nums[left - 1] < nums[right + 1]) {
            right++;
        } else {
            left--;
        }

        minVal = Math.min(minVal, nums[left], nums[right]);
        maxScore = Math.max(maxScore, minVal * (right - left + 1));
    }

    return maxScore;
};