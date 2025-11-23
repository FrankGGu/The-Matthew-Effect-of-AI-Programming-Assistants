var waysToSplit = function(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }

    let count = 0;
    for (let i = 1; i < n - 1; i++) {
        let leftSum = prefixSum[i];
        let rightSumMin = leftSum;
        let rightSumMax = Math.floor((prefixSum[n] - leftSum) / 2);
        let low = i + 1, high = n - 1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let rightSum = prefixSum[mid + 1] - prefixSum[i];
            if (rightSum < rightSumMin) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        let start = low;
        low = i + 1;
        high = n - 1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let rightSum = prefixSum[mid + 1] - prefixSum[i];
            if (rightSum <= rightSumMax) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        let end = high;
        if (start <= end) {
            count += end - start + 1;
        }
    }

    return count;
};