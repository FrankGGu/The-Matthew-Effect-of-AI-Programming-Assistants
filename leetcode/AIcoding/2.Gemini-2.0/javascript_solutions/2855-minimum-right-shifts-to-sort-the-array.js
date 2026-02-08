var minimumRightShifts = function(nums) {
    const n = nums.length;
    let shifted = 0;
    for (let i = 0; i < n - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            shifted++;
        }
    }

    if (shifted === 0) {
        return 0;
    }

    if (shifted > 1) {
        return -1;
    }

    if (nums[n - 1] > nums[0]) {
        return -1;
    }

    let shifts = 0;
    for (let i = n - 1; i > 0; i--) {
        if (nums[i] < nums[i - 1]) {
            shifts = n - i;
            break;
        }
    }

    return shifts;
};