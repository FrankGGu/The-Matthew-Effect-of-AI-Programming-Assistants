function maximumScore(nums, k) {
    const n = nums.length;
    let left = k, right = k;
    let minValue = nums[k];
    let maxScore = nums[k];

    while (left > 0 || right < n - 1) {
        if (right === n - 1 || (left > 0 && nums[left - 1] >= nums[right + 1])) {
            left--;
        } else {
            right++;
        }
        minValue = Math.min(minValue, nums[left], nums[right]);
        maxScore = Math.max(maxScore, minValue * (right - left + 1));
    }

    return maxScore;
}