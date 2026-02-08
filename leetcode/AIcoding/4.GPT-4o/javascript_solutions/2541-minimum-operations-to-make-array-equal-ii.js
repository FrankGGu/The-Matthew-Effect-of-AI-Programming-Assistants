function minOperations(nums) {
    const n = nums.length;
    nums.sort((a, b) => a - b);
    let minOps = Infinity;

    for (let i = 0; i < n; i++) {
        let ops = 0;
        for (let j = 0; j < n; j++) {
            ops += Math.abs(nums[j] - nums[i]);
        }
        minOps = Math.min(minOps, ops);
    }

    return minOps;
}