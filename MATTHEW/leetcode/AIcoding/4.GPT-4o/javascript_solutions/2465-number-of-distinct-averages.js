function distinctAverages(nums) {
    const seen = new Set();
    nums.sort((a, b) => a - b);
    const n = nums.length;

    for (let i = 0; i < n / 2; i++) {
        seen.add((nums[i] + nums[n - 1 - i]) / 2);
    }

    return seen.size;
}