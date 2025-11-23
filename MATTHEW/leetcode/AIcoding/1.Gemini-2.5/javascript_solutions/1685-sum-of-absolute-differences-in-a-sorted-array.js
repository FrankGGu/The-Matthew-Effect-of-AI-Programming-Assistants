var sumAbsoluteDifferences = function(nums) {
    const n = nums.length;
    const result = new Array(n);

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const totalSum = prefixSum[n];

    for (let i = 0; i < n; i++) {
        const leftSum = prefixSum[i];
        const leftCount = i;

        const rightSum = totalSum - prefixSum[i + 1];
        const rightCount = n - 1 - i;

        result[i] = (leftCount * nums[i] - leftSum) + (rightSum - rightCount * nums[i]);
    }

    return result;
};