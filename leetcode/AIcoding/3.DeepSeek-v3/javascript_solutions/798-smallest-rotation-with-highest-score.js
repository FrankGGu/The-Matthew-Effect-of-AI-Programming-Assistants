var bestRotation = function(nums) {
    const n = nums.length;
    const diff = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        const left = (i - num + 1 + n) % n;
        const right = (i + 1) % n;

        if (left <= right) {
            diff[left]++;
            diff[right]--;
        } else {
            diff[left]++;
            diff[n]--;
            diff[0]++;
            diff[right]--;
        }
    }

    let maxScore = 0;
    let bestK = 0;
    let currentScore = 0;

    for (let k = 0; k < n; k++) {
        currentScore += diff[k];
        if (currentScore > maxScore) {
            maxScore = currentScore;
            bestK = k;
        }
    }

    return bestK;
};