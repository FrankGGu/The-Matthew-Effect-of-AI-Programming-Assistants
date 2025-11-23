var mctFromLeafValues = function(arr) {
    let dp = Array(arr.length).fill(null).map(() => Array(arr.length).fill(0));
    let maxVal = Array(arr.length).fill(null).map(() => Array(arr.length).fill(0));

    for (let i = 0; i < arr.length; i++) {
        maxVal[i][i] = arr[i];
        for (let j = i + 1; j < arr.length; j++) {
            maxVal[i][j] = Math.max(maxVal[i][j - 1], arr[j]);
        }
    }

    for (let len = 2; len <= arr.length; len++) {
        for (let i = 0; i <= arr.length - len; i++) {
            let j = i + len - 1;
            dp[i][j] = Infinity;
            for (let k = i; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j] + maxVal[i][k] * maxVal[k + 1][j]);
            }
        }
    }

    return dp[0][arr.length - 1];
};