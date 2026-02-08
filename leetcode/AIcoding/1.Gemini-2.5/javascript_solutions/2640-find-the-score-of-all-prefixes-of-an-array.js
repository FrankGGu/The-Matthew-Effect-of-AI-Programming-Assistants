var findPrefixScore = function(nums) {
    const n = nums.length;
    const score = new Array(n);
    let currentSum = 0;
    let currentMax = 0;

    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        currentMax = Math.max(currentMax, nums[i]);
        score[i] = currentSum + currentMax;
    }

    return score;
};