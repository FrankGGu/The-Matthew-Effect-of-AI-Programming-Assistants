var incremovableSubarrayCount = function(nums) {
    let n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let valid = true;
            let prev = -1;
            for (let k = 0; k < n; k++) {
                if (k >= i && k <= j) continue;
                if (nums[k] <= prev) {
                    valid = false;
                    break;
                }
                prev = nums[k];
            }
            if (valid) count++;
        }
    }

    return count;
};