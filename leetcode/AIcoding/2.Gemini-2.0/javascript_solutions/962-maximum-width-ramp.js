var maxWidthRamp = function(nums) {
    const n = nums.length;
    let maxWidth = 0;
    for (let i = 0; i < n; i++) {
        for (let j = n - 1; j > i; j--) {
            if (nums[i] <= nums[j]) {
                maxWidth = Math.max(maxWidth, j - i);
                break;
            }
        }
    }
    return maxWidth;
};