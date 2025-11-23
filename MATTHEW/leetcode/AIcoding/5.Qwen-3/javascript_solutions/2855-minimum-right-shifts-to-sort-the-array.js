var minimumRightShifts = function(nums) {
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        if (nums[i] > nums[(i + 1) % n]) {
            for (let j = 0; j < n - 1; j++) {
                if (nums[j] > nums[j + 1]) {
                    return -1;
                }
            }
            return (n - i - 1) % n;
        }
    }
    return 0;
};