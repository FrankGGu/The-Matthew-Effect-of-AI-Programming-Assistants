function sumScores(nums) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }
    let total = 0;
    for (let i = 0; i < n; i++) {
        total += prefix[i];
    }
    return total;
}