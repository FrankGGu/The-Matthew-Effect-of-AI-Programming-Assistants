var waysToSplit = function(nums) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    let res = 0;
    for (let i = 0; i < n - 2; i++) {
        const leftSum = prefix[i];
        let low = i + 1;
        let high = n - 2;
        let left = -1;
        let right = -1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            const midSum = prefix[mid] - prefix[i];
            const rightSum = prefix[n - 1] - prefix[mid];
            if (midSum >= leftSum && rightSum >= midSum) {
                left = mid;
                high = mid - 1;
            } else if (midSum < leftSum) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low = i + 1;
        high = n - 2;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            const midSum = prefix[mid] - prefix[i];
            const rightSum = prefix[n - 1] - prefix[mid];
            if (midSum >= leftSum && rightSum >= midSum) {
                right = mid;
                low = mid + 1;
            } else if (midSum < leftSum) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (left !== -1 && right !== -1) {
            res = (res + right - left + 1) % MOD;
        }
    }
    return res;
};