var bestRotation = function(nums) {
    const n = nums.length;
    const bad = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const lose = (i - nums[i] + 1 + n) % n;
        bad[lose]--;
    }

    let bestIndex = 0;
    let maxScore = 0;
    let currentScore = 0;
    for (let i = 0; i < n; i++) {
        currentScore += bad[i];
        if (currentScore > maxScore) {
            maxScore = currentScore;
            bestIndex = i;
        }
    }

    return bestIndex;
};