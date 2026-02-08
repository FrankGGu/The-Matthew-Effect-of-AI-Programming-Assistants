var maxSumOfThreeSubarrays = function(arr, k) {
    const n = arr.length;
    const sum = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        sum[i] = sum[i - 1] + arr[i - 1];
    }

    const dp1 = new Array(n).fill(0);
    const dp2 = new Array(n).fill(0);

    for (let i = k; i <= n; i++) {
        dp1[i - 1] = Math.max(dp1[i - 2], sum[i] - sum[i - k]);
    }

    for (let i = k * 2; i <= n; i++) {
        dp2[i - 1] = Math.max(dp2[i - 2], dp1[i - k - 1] + sum[i] - sum[i - k]);
    }

    let maxSum = 0;
    let index = -1;
    for (let i = k * 2; i <= n; i++) {
        const currentSum = dp2[i - 1];
        if (currentSum > maxSum) {
            maxSum = currentSum;
            index = i - 1;
        }
    }

    const result = [];
    for (let j = 0; j < 3; j++) {
        result[j] = index - k + 1;
        for (let i = 0; i < j; i++) {
            result[j] -= k;
        }
        index = dp1[index - 1] === dp1[index - k - 1] ? index - k - 1 : index - k;
    }

    return result;
};