var findDisappearedNumbers = function(nums) {
    const n = nums.length;

    // First pass: Mark numbers present by negating the value at their corresponding index
    for (let i = 0; i < n; i++) {
        const num = Math.abs(nums[i]);
        const index = num - 1;
        if (nums[index] > 0) {
            nums[index] *= -1;
        }
    }

    // Second pass: Collect numbers whose indices were not marked (i.e., remain positive)
    const result = [];
    for (let i = 0; i < n; i++) {
        if (nums[i] > 0) {
            result.push(i + 1);
        }
    }

    return result;
};