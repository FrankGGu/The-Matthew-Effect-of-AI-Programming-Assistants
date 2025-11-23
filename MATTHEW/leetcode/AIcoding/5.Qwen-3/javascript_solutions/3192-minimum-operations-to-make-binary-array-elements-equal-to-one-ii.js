function minOperations(nums) {
    let operations = 0;
    let flip = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] ^ flip) {
            operations++;
            flip ^= 1;
        }
    }
    return operations;
}