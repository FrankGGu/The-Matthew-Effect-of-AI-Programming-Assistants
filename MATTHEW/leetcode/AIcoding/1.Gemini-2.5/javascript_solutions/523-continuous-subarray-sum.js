var checkSubarraySum = function(nums, k) {
    const n = nums.length;
    if (n < 2) {
        return false;
    }

    const remainderMap = new Map();
    remainderMap.set(0, -1); 

    let currentSum = 0;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];

        let remainder;
        if (k === 0) {
            remainder = currentSum;
        } else {
            remainder = currentSum % k;
        }

        if (remainderMap.has(remainder)) {
            const prevIndex = remainderMap.get(remainder);
            if (i - prevIndex >= 2) {
                return true;
            }
        } else {
            remainderMap.set(remainder, i);
        }
    }

    return false;
};