function distanceSum(nums) {
    const n = nums.length;
    const res = new Array(n).fill(0);
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        left[i] = left[i - 1] + (i - 1 - 0) * (nums[i] - nums[i - 1]);
    }

    for (let i = n - 2; i >= 0; i--) {
        right[i] = right[i + 1] + (n - 1 - i) * (nums[i + 1] - nums[i]);
    }

    for (let i = 0; i < n; i++) {
        res[i] = left[i] + right[i];
    }

    return res;
}