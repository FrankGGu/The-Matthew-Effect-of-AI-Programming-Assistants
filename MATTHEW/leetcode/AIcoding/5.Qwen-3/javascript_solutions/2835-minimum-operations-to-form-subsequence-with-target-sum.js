function minOperations(nums, target) {
    let operations = 0;
    let carry = 0;

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        let bit = num + carry;
        let currentBit = bit % 2;
        carry = Math.floor(bit / 2);

        if (currentBit !== (target >> i) & 1) {
            operations++;
            carry += 1;
        }
    }

    return operations;
}