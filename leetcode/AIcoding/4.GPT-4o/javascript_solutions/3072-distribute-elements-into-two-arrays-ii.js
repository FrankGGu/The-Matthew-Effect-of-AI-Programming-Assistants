function distributeArray(nums) {
    const n = nums.length / 2;
    nums.sort((a, b) => a - b);
    const res = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < nums.length; i++) {
        res[i % 2].push(nums[i]);
    }

    return res.flat();
}