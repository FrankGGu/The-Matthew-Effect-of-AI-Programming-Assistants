var validSubarraySize = function(nums, threshold) {
    const n = nums.length;
    for (let len = 1; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let valid = true;
            for (let j = i; j < i + len; j++) {
                if (nums[j] <= threshold[len - 1]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return len;
            }
        }
    }
    return -1;
};