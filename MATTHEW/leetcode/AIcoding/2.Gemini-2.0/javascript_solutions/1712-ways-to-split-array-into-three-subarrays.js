var waysToSplit = function(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let count = 0;
    for (let i = 1; i < n - 1; i++) {
        let leftSum = prefixSum[i];
        let left = i + 1;
        let right = n - 1;
        let start = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            let midSum = prefixSum[mid] - prefixSum[i];
            if (midSum >= leftSum) {
                start = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i + 1;
        right = n - 1;
        let end = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            let midSum = prefixSum[mid] - prefixSum[i];
            let rightSum = prefixSum[n] - prefixSum[mid];
            if (midSum <= rightSum) {
                end = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (start !== -1 && end !== -1 && start <= end) {
            count = (count + (end - start + 1)) % 1000000007;
        }
    }

    return count;
};