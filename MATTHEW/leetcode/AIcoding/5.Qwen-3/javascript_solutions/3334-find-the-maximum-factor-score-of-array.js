function maxFactorScore(nums) {
    let maxScore = 0;
    for (let i = 0; i < nums.length; i++) {
        let score = 1;
        for (let j = 2; j <= Math.sqrt(nums[i]); j++) {
            if (nums[i] % j === 0) {
                score *= j;
                if (j !== nums[i] / j) {
                    score *= nums[i] / j;
                }
            }
        }
        if (score > maxScore) {
            maxScore = score;
        }
    }
    return maxScore;
}