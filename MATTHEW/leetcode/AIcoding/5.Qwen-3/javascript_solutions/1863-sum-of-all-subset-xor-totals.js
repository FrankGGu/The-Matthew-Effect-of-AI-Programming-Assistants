function subsetXORs(nums) {
    let result = 0;
    const n = nums.length;
    for (let mask = 1; mask < (1 << n); mask++) {
        let xor = 0;
        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                xor ^= nums[i];
            }
        }
        result += xor;
    }
    return result;
}