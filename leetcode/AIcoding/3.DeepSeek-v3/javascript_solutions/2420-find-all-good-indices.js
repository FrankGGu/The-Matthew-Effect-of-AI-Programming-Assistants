var goodIndices = function(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(1);
    const right = new Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        if (nums[i] <= nums[i - 1]) {
            left[i] = left[i - 1] + 1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] <= nums[i + 1]) {
            right[i] = right[i + 1] + 1;
        }
    }

    const res = [];
    for (let i = k; i < n - k; i++) {
        if (left[i - 1] >= k && right[i + 1] >= k) {
            res.push(i);
        }
    }

    return res;
};