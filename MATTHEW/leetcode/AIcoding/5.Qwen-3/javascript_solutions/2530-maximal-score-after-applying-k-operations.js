function maxScore(nums, k) {
    nums.sort((a, b) => b - a);
    let score = 0;
    for (let i = 0; i < k; i++) {
        score += nums[i];
    }
    return score;
}