var minimizeMax = function(nums, p) {
    if (p === 0) return 0;
    nums.sort((a, b) => a - b);
    let left = 0, right = nums[nums.length - 1] - nums[0];

    const canFormPairs = (maxDiff) => {
        let count = 0;
        for (let i = 0; i < nums.length - 1 && count < p; ) {
            if (nums[i + 1] - nums[i] <= maxDiff) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return count >= p;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canFormPairs(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};