var findPrefixScore = function(nums) {
    const n = nums.length;
    const res = new Array(n).fill(0);
    let max = 0;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        max = Math.max(max, nums[i]);
        sum += nums[i] + max;
        res[i] = sum;
    }

    return res;
};