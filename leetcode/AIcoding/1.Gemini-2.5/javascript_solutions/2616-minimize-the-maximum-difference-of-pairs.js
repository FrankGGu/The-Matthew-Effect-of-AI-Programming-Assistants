var minimizeMax = function(nums, p) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    const canFormPairs = (maxDiff) => {
        let count = 0;
        let i = 0;
        while (i < n - 1) {
            if (nums[i + 1] - nums[i] <= maxDiff) {
                count++;
                i += 2;
            } else {
                i += 1;
            }
            if (count >= p) {
                return true;
            }
        }
        return count >= p;
    };

    let low = 0;
    let high = nums[n - 1] - nums[0];
    let ans = high;

    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        if (canFormPairs(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};