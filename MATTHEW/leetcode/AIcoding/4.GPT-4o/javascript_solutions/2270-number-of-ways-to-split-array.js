var waysToSplit = function(nums) {
    const mod = 1e9 + 7;
    const n = nums.length;
    const prefixSum = new Array(n + 1);
    prefixSum[0] = 0;

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let count = 0;
    for (let i = 1; i < n; i++) {
        let leftSum = prefixSum[i];
        let rightSum = prefixSum[n] - leftSum;

        let low = i, high = n;

        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (prefixSum[mid] - leftSum < leftSum) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        let start = low;

        low = i;
        high = n;

        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (rightSum - (prefixSum[mid] - leftSum) < prefixSum[mid] - leftSum) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        let end = low;

        if (start <= end) {
            count = (count + end - start) % mod;
        }
    }

    return count;
};