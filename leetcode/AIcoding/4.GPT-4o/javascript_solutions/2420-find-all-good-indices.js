var findGoodIndices = function(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const result = [];

    for (let i = 1; i < n; i++) {
        if (nums[i - 1] <= nums[i]) left[i] = left[i - 1] + 1;
    }

    for (let i = n - 2; i >= 0; i--) {
        if (nums[i] >= nums[i + 1]) right[i] = right[i + 1] + 1;
    }

    for (let i = k; i < n - k; i++) {
        if (left[i] >= k && right[i] >= k) result.push(i);
    }

    return result;
};