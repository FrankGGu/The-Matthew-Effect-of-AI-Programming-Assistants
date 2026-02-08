var sumOfPowers = function(nums) {
    const MOD = 10 ** 9 + 7;
    nums.sort((a, b) => a - b);
    const n = nums.length;

    let totalPower = 0;
    // currentSumMinContributions represents S_j = sum_{k=0}^{j-1} (nums[k] * 2^(j-k-1))
    // This sum accounts for all subsequences where nums[j] is the maximum,
    // and nums[k] (for k < j) is the minimum.
    let currentSumMinContributions = 0; 

    for (let j = 0; j < n; j++) {
        // Calculate (nums[j])^2, which is a common factor for all subsequences
        // where nums[j] is the maximum element.
        let termForMaxSquare = (nums[j] * nums[j]) % MOD;

        // Calculate the sum of minimum element contributions for the current nums[j] as maximum.
        // This sum includes two parts:
        // 1. nums[j] itself: for the subsequence consisting only of [nums[j]] (where nums[j] is both min and max).
        // 2. currentSumMinContributions: for subsequences where nums[j] is max and nums[k] (k < j) is min.
        let minPartSum = (currentSumMinContributions + nums[j]) % MOD;

        // Add the contribution of all subsequences with nums[j] as maximum to the total power.
        totalPower = (totalPower + termForMaxSquare * minPartSum) % MOD;

        // Update currentSumMinContributions for the next iteration (j+1).
        // The recurrence relation is S_{j+1} = (2 * S_j + nums[j]) % MOD.
        // This is derived from:
        // S_{j+1} = sum_{k=0}^{j} (nums[k] * 2^(j+1-k-1))
        //         = sum_{k=0}^{j} (nums[k] * 2^(j-k))
        //         = 2 * sum_{k=0}^{j-1} (nums[k] * 2^(j-k-1)) + nums[j] * 2^0
        //         = 2 * S_j + nums[j]
        currentSumMinContributions = (2 * currentSumMinContributions + nums[j]) % MOD;
    }

    return totalPower;
};