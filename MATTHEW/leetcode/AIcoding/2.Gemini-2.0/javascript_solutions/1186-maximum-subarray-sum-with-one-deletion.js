var maximumSum = function(arr) {
    let n = arr.length;
    let dp0 = new Array(n).fill(0);
    let dp1 = new Array(n).fill(0);
    let maxSum = arr[0];
    dp0[0] = arr[0];
    dp1[0] = 0;

    for (let i = 1; i < n; i++) {
        dp0[i] = Math.max(arr[i], dp0[i - 1] + arr[i]);
        dp1[i] = Math.max(dp0[i - 1], dp1[i - 1] + arr[i]);
        maxSum = Math.max(maxSum, dp0[i], dp1[i]);
    }

    return maxSum;
};