var maxScore = function(nums) {
    const n = nums.length;
    nums.sort((a, b) => b - a);
    let prefix = [];
    prefix[0] = nums[0];
    let res = prefix[0] > 0 ? 1 : 0;
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
        if (prefix[i] > 0) {
            res = i + 1;
        }
    }
    return res;
};