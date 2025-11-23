var largestDivisibleSubset = function(nums) {
    if (nums === null || nums.length === 0) {
        return [];
    }

    nums.sort((a, b) => a - b);

    const n = nums.length;
    const dp = new Array(n).fill(1);
    const prev = new Array(n).fill(-1);

    let maxLen = 1;
    let maxIdx = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] % nums[j] === 0) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
            maxIdx = i;
        }
    }

    const result = [];
    let curr = maxIdx;
    while (curr !== -1) {
        result.unshift(nums[curr]);
        curr = prev[curr];
    }

    return result;
};