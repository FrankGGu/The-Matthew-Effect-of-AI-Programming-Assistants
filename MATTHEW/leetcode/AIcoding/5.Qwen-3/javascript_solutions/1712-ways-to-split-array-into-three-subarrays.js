function waysToSplit(nums) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    let result = 0;
    for (let i = 0; i < n - 2; i++) {
        let leftSum = prefix[i];
        let totalSum = prefix[n - 1];
        let rightSum = totalSum - leftSum;

        if (rightSum <= 0) continue;

        let low = i + 1;
        let high = n - 1;
        let first = -1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let midSum = prefix[mid] - leftSum;
            if (midSum > rightSum / 2) {
                high = mid - 1;
            } else {
                first = mid;
                low = mid + 1;
            }
        }

        if (first === -1) continue;

        low = first;
        high = n - 1;
        let last = -1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let midSum = prefix[mid] - leftSum;
            if (midSum > rightSum / 2) {
                high = mid - 1;
            } else {
                last = mid;
                low = mid + 1;
            }
        }

        if (last !== -1) {
            result += last - first + 1;
        }
    }

    return result;
}