function minNumberGame(nums) {
    const n = nums.length;
    for (let i = 0; i < n - 1; i += 2) {
        nums[i / 2] = Math.min(nums[i], nums[i + 1]);
    }
    return n % 2 === 0 ? nums[0] : Math.min(nums[0], nums[n / 2]);
}