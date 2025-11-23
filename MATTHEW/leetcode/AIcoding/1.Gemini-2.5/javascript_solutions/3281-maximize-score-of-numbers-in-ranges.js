var maximumScore = function(nums, k) {
    const n = nums.length;
    let left = k;
    let right = k;
    let currentMin = nums[k];
    let maxScore = nums[k];

    while (left > 0 || right < n - 1) {
        if (left === 0) {
            right++;
            currentMin = Math.min(currentMin, nums[right]);
        } else if (right === n - 1) {
            left--;
            currentMin = Math.min(currentMin, nums[left]);
        } else if (nums[left - 1] > nums[right + 1]) {
            left--;
            currentMin = Math.min(currentMin, nums[left]);
        } else {
            right++;
            currentMin = Math.min(currentMin, nums[right]);
        }
        maxScore = Math.max(maxScore, currentMin * (right - left + 1));
    }

    return maxScore;
};