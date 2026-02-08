var minimizeMax = function(nums, p) {
    nums.sort((a, b) => a - b);
    let left = 0, right = nums[nums.length - 1] - nums[0];

    const canPair = (maxDiff) => {
        let count = 0;
        for (let i = 1; i < nums.length; i++) {
            if (nums[i] - nums[i - 1] <= maxDiff) {
                count++;
                i++; // skip the next element as it's paired
            }
        }
        return count >= p;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (canPair(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};