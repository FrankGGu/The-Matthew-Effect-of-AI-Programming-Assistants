var minimumMountainRemovals = function(nums) {
    const n = nums.length;
    const left = new Array(n).fill(1);
    const right = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                left[i] = Math.max(left[i], left[j] + 1);
            }
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        for (let j = n - 1; j > i; j--) {
            if (nums[j] < nums[i]) {
                right[i] = Math.max(right[i], right[j] + 1);
            }
        }
    }

    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        if (left[i] > 1 && right[i] > 1) {
            maxLen = Math.max(maxLen, left[i] + right[i] - 1);
        }
    }

    return n - maxLen;
};