function maxMinGameScore(nums) {
    nums.sort((a, b) => a - b);
    let left = 0, right = nums.length - 1;
    let minScore = Infinity;
    while (left < right) {
        minScore = Math.min(minScore, nums[left] + nums[right]);
        left++;
        right--;
    }
    return minScore;
}