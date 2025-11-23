var minOperations = function(nums) {
    let operations = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let currentValue = nums[i];

        // If 'operations' is odd, it means an odd number of flips have occurred
        // at indices j < i. This effectively flips the current element's state.
        if (operations % 2 === 1) {
            currentValue = 1 - currentValue;
        }

        // If the effective value of nums[i] is 0, we must perform an operation
        // at index i to make it 1. This operation increments the total operations
        // count and affects all subsequent elements (i to n-1).
        if (currentValue === 0) {
            operations++;
        }
    }

    return operations;
};