function findSubarrays(nums) {
    const sums = new Set();
    for (let i = 0; i < nums.length - 1; i++) {
        const sum = nums[i] + nums[i + 1];
        if (sums.has(sum)) {
            return true;
        }
        sums.add(sum);
    }
    return false;
}