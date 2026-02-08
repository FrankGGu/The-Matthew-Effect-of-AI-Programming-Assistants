var minimumLimit = function(nums, maxOperations) {
    let low = 1;
    let high = 0;
    for (const num of nums) {
        high = Math.max(high, num);
    }

    let ans = high;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        let operationsNeeded = 0;

        for (const num of nums) {
            if (num > mid) {
                // Number of operations to split 'num' into bags of size at most 'mid'
                // For example, if num=7, mid=3: ceil(7/3) = 3 bags. Requires 3-1 = 2 operations.
                // This can be calculated as floor((num - 1) / mid)
                operationsNeeded += Math.floor((num - 1) / mid);
            }
        }

        if (operationsNeeded <= maxOperations) {
            // 'mid' is a possible answer, try for a smaller one
            ans = mid;
            high = mid - 1;
        } else {
            // 'mid' is too small, we need a larger limit
            low = mid + 1;
        }
    }

    return ans;
};