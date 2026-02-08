var countInterestingSubarrays = function(nums, modulo, k) {
    let ans = 0;
    let currentSum = 0;
    const prefixSumCounts = new Map();
    prefixSumCounts.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        const isDivisible = (nums[i] % modulo === 0) ? 1 : 0;
        currentSum += isDivisible;

        // We are looking for a previous prefix sum `prevSum` such that `currentSum - prevSum == k`.
        // This means `prevSum == currentSum - k`.
        // The `prefixSumCounts` map stores frequencies of `prevSum` values encountered so far.
        ans += prefixSumCounts.get(currentSum - k) || 0;

        prefixSumCounts.set(currentSum, (prefixSumCounts.get(currentSum) || 0) + 1);
    }

    return ans;
};