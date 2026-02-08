var countElements = function(nums) {
    if (nums.length <= 2) return 0;

    let minVal = nums[0];
    let maxVal = nums[0];

    for (let i = 1; i < nums.length; i++) {
        minVal = Math.min(minVal, nums[i]);
        maxVal = Math.max(maxVal, nums[i]);
    }

    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > minVal && nums[i] < maxVal) {
            count++;
        }
    }

    return count;
};