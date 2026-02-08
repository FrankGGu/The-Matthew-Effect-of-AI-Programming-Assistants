var firstMissingPositive = function(nums) {
    const n = nums.length;

    // Check if 1 is present in the array. If not, you're done and 1 is the answer.
    if (!nums.includes(1)) {
        return 1;
    }

    // Replace negative numbers, zeros,
    // and numbers larger than n with 1s.
    // After this conversion, nums will contain
    // only positive numbers.
    for (let i = 0; i < n; i++) {
        if (nums[i] <= 0 || nums[i] > n) {
            nums[i] = 1;
        }
    }

    // Use the index as a hash key and the sign of the number as a presence detector.
    // For example, if nums[1] is negative, that means that the number `1`
    // is present in the array. 
    // If nums[2] is positive, the number 2 is missing.
    for (let i = 0; i < n; i++) {
        let a = Math.abs(nums[i]);
        // If you meet number a in the array, change the sign of the a-th element.
        // Be careful with duplicates: do it only once.
        if (a == n) {
            nums[0] = - Math.abs(nums[0]);
        } else {
            nums[a] = - Math.abs(nums[a]);
        }
    }

    // Now the index of the first positive number 
    // is equal to the first positive missing number.
    for (let i = 1; i < n; i++) {
        if (nums[i] > 0) {
            return i;
        }
    }

    if (nums[0] > 0) {
        return n;
    }

    return n + 1;
};