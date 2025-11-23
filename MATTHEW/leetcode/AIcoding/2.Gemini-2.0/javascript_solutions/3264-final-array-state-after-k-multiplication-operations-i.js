var solve = function(nums, k, x) {
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        if (nums[i] < 0) {
            nums[i] *= -1;
        }
    }
    let negCount = 0;
    for (let num of nums) {
        if (num < 0) {
            negCount++;
        }
    }

    for (let i = 0; i < k; i++) {
        let minAbsIndex = 0;
        for (let j = 1; j < n; j++) {
            if (Math.abs(nums[j]) < Math.abs(nums[minAbsIndex])) {
                minAbsIndex = j;
            }
        }

        nums[minAbsIndex] *= -1;
    }

    return nums;
};