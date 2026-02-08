var minimizeTheMaximumPairDifference = function(nums, p) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    // Helper function to check if it's possible to form 'p' pairs
    // with a maximum difference of 'x' or less.
    const check = (x) => {
        let count = 0;
        let i = 0;
        while (i < n - 1) {
            if (nums[i+1] - nums[i] <= x) {
                // If the difference is within 'x', form a pair
                // and skip both elements.
                count++;
                i += 2;
            } else {
                // If the difference is too large, skip only the current element
                // and try to form a pair with the next one.
                i += 1;
            }
            if (count >= p) {
                return true;
            }
        }
        return count >= p;
    };

    let low = 0;
    let high = nums[n-1] - nums[0]; // Maximum possible difference
    let ans = high;

    // Binary search for the minimum possible maximum difference
    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            // If it's possible to form 'p' pairs with max diff 'mid',
            // try for an even smaller max diff.
            ans = mid;
            high = mid - 1;
        } else {
            // If not possible, we need a larger max diff.
            low = mid + 1;
        }
    }

    return ans;
};