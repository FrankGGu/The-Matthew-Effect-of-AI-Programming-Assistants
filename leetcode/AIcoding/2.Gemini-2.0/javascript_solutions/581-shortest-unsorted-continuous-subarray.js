var findUnsortedSubarray = function(nums) {
    const n = nums.length;
    let left = -1, right = -1;
    let maxVal = nums[0];
    let minVal = nums[n - 1];

    for (let i = 1; i < n; i++) {
        if (nums[i] < maxVal) {
            right = i;
        } else {
            maxVal = nums[i];
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] > minVal) {
            left = i;
        } else {
            minVal = nums[i];
        }
    }

    return right === -1 ? 0 : right - left + 1;
};