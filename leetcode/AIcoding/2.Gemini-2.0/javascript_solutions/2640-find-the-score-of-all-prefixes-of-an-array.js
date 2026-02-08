var findPrefixScore = function(nums) {
    const n = nums.length;
    const scores = new Array(n);
    let maxVal = 0;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        maxVal = Math.max(maxVal, nums[i]);
        sum += nums[i] + maxVal;
        scores[i] = sum;
    }

    return scores;
};