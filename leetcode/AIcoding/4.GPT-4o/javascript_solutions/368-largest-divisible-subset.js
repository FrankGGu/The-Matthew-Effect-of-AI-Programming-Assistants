var largestDivisibleSubset = function(nums) {
    if (nums.length === 0) return [];
    nums.sort((a, b) => a - b);
    const dp = new Array(nums.length).fill(1);
    const prev = new Array(nums.length).fill(-1);
    let maxIndex = 0;

    for (let i = 1; i < nums.length; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] % nums[j] === 0 && dp[i] < dp[j] + 1) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
        if (dp[i] > dp[maxIndex]) {
            maxIndex = i;
        }
    }

    const result = [];
    for (let i = maxIndex; i >= 0; i = prev[i]) {
        result.push(nums[i]);
        if (prev[i] === -1) break;
    }
    return result.reverse();
};