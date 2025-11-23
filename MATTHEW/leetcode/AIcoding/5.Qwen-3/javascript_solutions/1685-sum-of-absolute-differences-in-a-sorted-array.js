function absoluteSum(nums) {
    const n = nums.length;
    const res = new Array(n).fill(0);
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (let i = 0; i < n; i++) {
        res[i] = nums[i] * i - prefix[i] + (prefix[n] - prefix[i + 1]) - nums[i] * (n - i - 1);
    }

    return res;
}