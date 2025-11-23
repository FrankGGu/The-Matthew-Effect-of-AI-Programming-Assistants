var getMaxFunctionValue = function(arr, k) {
    const n = arr.length;
    const logK = Math.floor(Math.log2(k));
    const dp = Array(n).fill(null).map(() => Array(logK + 1).fill(0));
    const sum = Array(n).fill(null).map(() => Array(logK + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = arr[i];
        sum[i][0] = arr[i];
    }

    for (let j = 1; j <= logK; j++) {
        for (let i = 0; i < n; i++) {
            dp[i][j] = dp[dp[i][j - 1]][j - 1];
            sum[i][j] = sum[i][j - 1] + sum[dp[i][j - 1]][j - 1];
        }
    }

    let ans = 0;
    for (let start = 0; start < n; start++) {
        let curr = start;
        let currSum = 0;
        let remainingK = k;

        for (let j = logK; j >= 0; j--) {
            if ((remainingK & (1 << j)) > 0) {
                currSum += sum[curr][j];
                curr = dp[curr][j];
            }
        }
        ans = Math.max(ans, currSum);
    }

    return ans;
};