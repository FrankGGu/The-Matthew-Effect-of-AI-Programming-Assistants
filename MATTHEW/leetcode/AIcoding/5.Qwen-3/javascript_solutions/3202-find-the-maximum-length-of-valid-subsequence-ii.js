function findMaximumLength(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(1);
    const last = new Array(n).fill(-1);
    const prev = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                last[i] = j;
                prev[i] = j;
            }
        }
    }

    let maxLen = 0;
    let endIndex = 0;

    for (let i = 0; i < n; i++) {
        if (dp[i] > maxLen) {
            maxLen = dp[i];
            endIndex = i;
        }
    }

    const result = [];
    let current = endIndex;
    while (current !== -1) {
        result.push(nums[current]);
        current = prev[current];
    }

    return result.length;
}