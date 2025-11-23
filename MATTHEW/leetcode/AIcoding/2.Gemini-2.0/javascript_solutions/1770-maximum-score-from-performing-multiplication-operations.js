var maximumScore = function(nums, multipliers) {
    const n = nums.length;
    const m = multipliers.length;
    const dp = Array(m + 1).fill(null).map(() => Array(m + 1).fill(-Infinity));

    function solve(opIndex, left) {
        if (opIndex === m) {
            return 0;
        }

        if (dp[opIndex][left] !== -Infinity) {
            return dp[opIndex][left];
        }

        const right = n - 1 - (opIndex - left);

        const chooseLeft = multipliers[opIndex] * nums[left] + solve(opIndex + 1, left + 1);
        const chooseRight = multipliers[opIndex] * nums[right] + solve(opIndex + 1, left);

        dp[opIndex][left] = Math.max(chooseLeft, chooseRight);
        return dp[opIndex][left];
    }

    return solve(0, 0);
};