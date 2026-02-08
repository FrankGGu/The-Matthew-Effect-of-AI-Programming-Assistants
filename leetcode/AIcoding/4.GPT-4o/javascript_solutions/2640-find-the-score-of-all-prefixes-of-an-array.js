var findPrefixScore = function(nums) {
    let prefixScores = new Array(nums.length);
    let maxNum = 0;
    let totalScore = 0;

    for (let i = 0; i < nums.length; i++) {
        maxNum = Math.max(maxNum, nums[i]);
        totalScore += nums[i] + maxNum;
        prefixScores[i] = totalScore;
    }

    return prefixScores;
};