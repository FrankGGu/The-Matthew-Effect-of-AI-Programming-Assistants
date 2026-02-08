var minimumRightShifts = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return 0;
    }

    let descentCount = 0;
    let descentIndex = -1;

    for (let i = 0; i < n - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            descentCount++;
            descentIndex = i;
        }
    }

    if (descentCount === 0) {
        return 0;
    } else if (descentCount === 1) {
        if (nums[n - 1] <= nums[0]) {
            return n - (descentIndex + 1);
        } else {
            return -1;
        }
    } else {
        return -1;
    }
};