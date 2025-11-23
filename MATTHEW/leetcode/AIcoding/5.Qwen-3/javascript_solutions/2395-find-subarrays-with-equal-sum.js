function checkIfEqualSumSubarrays(nums) {
    const n = nums.length;
    for (let i = 0; i <= n - 2; i++) {
        const sum1 = nums[i] + nums[i + 1];
        for (let j = i + 1; j <= n - 2; j++) {
            const sum2 = nums[j] + nums[j + 1];
            if (sum1 === sum2) {
                return true;
            }
        }
    }
    return false;
}