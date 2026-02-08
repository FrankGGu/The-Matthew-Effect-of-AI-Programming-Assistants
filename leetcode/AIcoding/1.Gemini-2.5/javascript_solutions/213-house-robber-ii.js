var rob = function(nums) {
    const n = nums.length;

    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return nums[0];
    }

    // Helper function to solve the House Robber I problem for a linear array
    const robLinear = (arr) => {
        if (arr.length === 0) {
            return 0;
        }
        if (arr.length === 1) {
            return arr[0];
        }

        let prev2 = 0; // Represents dp[i-2]
        let prev1 = 0; // Represents dp[i-1]

        for (let i = 0; i < arr.length; i++) {
            const currentMax = Math.max(prev1, prev2 + arr[i]);
            prev2 = prev1;
            prev1 = currentMax;
        }
        return prev1;
    };

    // Case 1: Rob houses from index 0 to n-2 (exclude the last house)
    const result1 = robLinear(nums.slice(0, n - 1));

    // Case 2: Rob houses from index 1 to n-1 (exclude the first house)
    const result2 = robLinear(nums.slice(1, n));

    // The maximum amount is the greater of these two cases
    return Math.max(result1, result2);
};