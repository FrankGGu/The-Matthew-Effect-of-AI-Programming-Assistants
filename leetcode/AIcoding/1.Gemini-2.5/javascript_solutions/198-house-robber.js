var rob = function(nums) {
    const n = nums.length;

    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return nums[0];
    }

    let prev2 = nums[0];
    let prev1 = Math.max(nums[0], nums[1]);

    for (let i = 2; i < n; i++) {
        let current = Math.max(nums[i] + prev2, prev1);
        prev2 = prev1;
        prev1 = current;
    }

    return prev1;
};