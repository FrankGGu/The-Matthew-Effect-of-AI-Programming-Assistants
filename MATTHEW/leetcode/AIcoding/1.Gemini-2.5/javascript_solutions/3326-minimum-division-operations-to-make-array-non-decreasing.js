var minimumOperations = function(nums) {
    let n = nums.length;
    if (n <= 1) {
        return 0;
    }

    let operations = 0;
    // prev_val stores the value of nums[i+1] (or the modified value)
    // which serves as the upper bound for nums[i].
    let prev_val = nums[n - 1];

    for (let i = n - 2; i >= 0; i--) {
        let curr_val = nums[i];

        if (curr_val > prev_val) {
            // If curr_val is greater than the allowed upper bound (prev_val),
            // we must perform at least one division operation on curr_val.
            operations++;

            // We need to replace curr_val with floor(curr_val / x) such that
            // floor(curr_val / x) <= prev_val.
            // To make it easier for the element nums[i-1], we want the new value
            // of nums[i] to be as large as possible, while still satisfying the condition.
            // The largest possible value for floor(curr_val / x) is prev_val.
            // We need to find the smallest integer x such that floor(curr_val / x) <= prev_val.
            // This is equivalent to curr_val / x < prev_val + 1,
            // which means x > curr_val / (prev_val + 1).
            // The smallest integer x satisfying this is floor(curr_val / (prev_val + 1)) + 1.
            let x_min = Math.floor(curr_val / (prev_val + 1)) + 1;

            // Update prev_val to the new value of nums[i] after division.
            // This new value becomes the upper bound for nums[i-1].
            prev_val = Math.floor(curr_val / x_min);
        } else {
            // If curr_val is already less than or equal to prev_val,
            // no operation is needed for nums[i] to satisfy the non-decreasing condition
            // with nums[i+1].
            // However, curr_val itself becomes the new upper bound for nums[i-1].
            prev_val = curr_val;
        }
    }

    return operations;
};