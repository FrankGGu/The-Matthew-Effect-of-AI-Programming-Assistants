var waysToSplit = function(nums) {
    const MOD = 1e9 + 7;
    let n = nums.length;
    let prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let count = 0;
    for (let i = 1; i < n; i++) {
        let leftSum = prefixSum[i];
        let low = i, high = n;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (prefixSum[mid] - leftSum < leftSum) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        let leftBound = low;

        low = i;
        high = n;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (prefixSum[mid] - leftSum > 2 * leftSum) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        let rightBound = low;

        count = (count + rightBound - leftBound) % MOD;
    }

    return count;
};