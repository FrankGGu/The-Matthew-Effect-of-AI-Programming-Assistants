var findKey = function(nums) {
    const n = nums.length;
    if (n < 3) return -1;

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (j !== i && nums[j] % nums[i] === 0) {
                count++;
            }
        }
        if (count > n / 2) {
            return nums[i];
        }
    }

    return -1;
};