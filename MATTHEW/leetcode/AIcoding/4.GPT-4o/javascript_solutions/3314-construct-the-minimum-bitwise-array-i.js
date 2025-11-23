function findBitwiseArray(nums) {
    const n = nums.length;
    const result = new Array(n);
    result[0] = nums[0];

    for (let i = 1; i < n; i++) {
        result[i] = nums[i] ^ nums[i - 1];
    }

    return result;
}