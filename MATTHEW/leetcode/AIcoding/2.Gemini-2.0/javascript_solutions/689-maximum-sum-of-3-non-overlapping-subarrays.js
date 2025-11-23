var maxSumOfThreeSubarrays = function(nums, k) {
    const n = nums.length;
    const sum = new Array(n - k + 1).fill(0);
    let currentSum = 0;
    for (let i = 0; i < k; i++) {
        currentSum += nums[i];
    }
    sum[0] = currentSum;
    for (let i = k; i < n; i++) {
        currentSum += nums[i] - nums[i - k];
        sum[i - k + 1] = currentSum;
    }

    const left = new Array(n - k + 1).fill(0);
    let maxIndex = 0;
    for (let i = 0; i < n - k + 1; i++) {
        if (sum[i] > sum[maxIndex]) {
            maxIndex = i;
        }
        left[i] = maxIndex;
    }

    const right = new Array(n - k + 1).fill(0);
    maxIndex = n - k;
    for (let i = n - k; i >= 0; i--) {
        if (sum[i] >= sum[maxIndex]) {
            maxIndex = i;
        }
        right[i] = maxIndex;
    }

    let ans = [-1, -1, -1];
    let maxSum = 0;
    for (let j = k; j <= n - 2 * k; j++) {
        const i = left[j - k];
        const l = right[j + k];
        const currentSum = sum[i] + sum[j] + sum[l];
        if (currentSum > maxSum) {
            maxSum = currentSum;
            ans = [i, j, l];
        }
    }

    return ans;
};