var countOperationsToEmptyArray = function(nums) {
    const n = nums.length;
    const pos = {};
    for (let i = 0; i < n; i++) {
        pos[nums[i]] = i;
    }
    nums.sort((a, b) => a - b);
    let res = n;
    for (let i = 1; i < n; i++) {
        if (pos[nums[i]] < pos[nums[i - 1]]) {
            res += n - i;
        }
    }
    return res;
};