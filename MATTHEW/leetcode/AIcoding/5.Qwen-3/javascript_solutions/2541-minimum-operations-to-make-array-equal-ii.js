function minOperations(nums, target) {
    let operations = 0;
    let carry = 0;

    for (let i = 0; i < nums.length; i++) {
        let sum = nums[i] + carry;
        let diff = sum - target;

        if (diff > 0) {
            operations += diff;
            carry = 0;
        } else if (diff < 0) {
            operations += Math.abs(diff);
            carry = Math.abs(diff);
        }
    }

    return operations;
}