function minimumBitwiseArray(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);

    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (let num of nums) {
            if (num & (1 << i)) count++;
        }
        if (count > 0) {
            for (let j = 0; j < n; j++) {
                if (nums[j] & (1 << i)) {
                    result[j] |= (1 << i);
                }
            }
        }
    }

    return result;
}