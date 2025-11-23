var maxSumOfThreeSubarrays = function(nums, k) {
    const n = nums.length;

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const lenW = n - k + 1;
    const W = new Array(lenW);
    for (let i = 0; i < lenW; i++) {
        W[i] = prefixSum[i + k] - prefixSum[i];
    }

    const left = new Array(lenW);
    left[0] = 0;
    for (let i = 1; i < lenW; i++) {
        if (W[i] > W[left[i - 1]]) {
            left[i] = i;
        } else {
            left[i] = left[i - 1];
        }
    }

    const right = new Array(lenW);
    right[lenW - 1] = lenW - 1;
    for (let i = lenW - 2; i >= 0; i--) {
        if (W[i] >= W[right[i + 1]]) {
            right[i] = i;
        } else {
            right[i] = right[i + 1];
        }
    }

    let maxSum = -1;
    let result = [];

    for (let idx_j = k; idx_j <= lenW - k - 1; idx_j++) {
        const idx_i = left[idx_j - k];
        const idx_l = right[idx_j + k];

        const currentSum = W[idx_i] + W[idx_j] + W[idx_l];

        if (currentSum > maxSum) {
            maxSum = currentSum;
            result = [idx_i, idx_j, idx_l];
        }
    }

    return result;
};