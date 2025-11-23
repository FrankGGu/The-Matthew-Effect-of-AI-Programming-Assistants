var countOperationsToEmptyArray = function(nums) {
    const n = nums.length;
    const idx = Array(n);
    for (let i = 0; i < n; i++) {
        idx[i] = i;
    }
    idx.sort((a, b) => nums[a] - nums[b]);
    let ans = n;
    for (let i = 1; i < n; i++) {
        if (idx[i] < idx[i - 1]) {
            ans += n - i;
        }
    }
    return ans;
};