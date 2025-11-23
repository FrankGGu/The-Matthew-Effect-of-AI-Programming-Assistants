var maximumTop = function(nums, k) {
    const n = nums.length;

    if (n === 1) {
        return k % 2 === 0 ? nums[0] : -1;
    }

    if (k > n) {
        return Math.max(...nums);
    }

    if (k === n) {
        return Math.max(...nums.slice(0, n - 1));
    }

    let maxVal = -1;
    for (let i = 0; i < Math.min(k - 1, n); i++) {
        maxVal = Math.max(maxVal, nums[i]);
    }

    if (k < n) {
        maxVal = Math.max(maxVal, nums[k]);
    }

    return maxVal;
};