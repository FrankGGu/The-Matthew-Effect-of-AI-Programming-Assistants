var countElements = function(nums) {
    if (nums.length < 3) {
        return 0;
    }

    let minVal = nums[0];
    let maxVal = nums[0];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    if (minVal === maxVal) {
        return 0;
    }

    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > minVal && nums[i] < maxVal) {
            count++;
        }
    }

    return count;
};