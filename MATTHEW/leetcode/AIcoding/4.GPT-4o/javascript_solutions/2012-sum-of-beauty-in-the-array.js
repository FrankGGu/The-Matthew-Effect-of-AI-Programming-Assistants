var sumOfBeauty = function(nums) {
    let n = nums.length;
    let totalBeauty = 0;

    for (let i = 1; i < n - 1; i++) {
        let leftMin = Math.min(nums[i - 1], nums[i]);
        let rightMin = Math.min(nums[i], nums[i + 1]);
        let leftMax = Math.max(nums[i - 1], nums[i]);
        let rightMax = Math.max(nums[i], nums[i + 1]);

        if (nums[i] > leftMax && nums[i] > rightMax) {
            totalBeauty += 2;
        } else if (nums[i] < leftMin && nums[i] < rightMin) {
            totalBeauty += 2;
        } else if (nums[i] > leftMax || nums[i] > rightMax || nums[i] < leftMin || nums[i] < rightMin) {
            totalBeauty += 1;
        }
    }

    return totalBeauty;
};