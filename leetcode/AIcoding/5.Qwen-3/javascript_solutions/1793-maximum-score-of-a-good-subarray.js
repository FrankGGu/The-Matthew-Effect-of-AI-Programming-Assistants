function maximumScore(nums, minIndices) {
    let n = nums.length;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        left[i] = i;
        if (i > 0 && nums[i] < nums[left[i - 1]]) {
            left[i] = left[i - 1];
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        right[i] = i;
        if (i < n - 1 && nums[i] < nums[right[i + 1]]) {
            right[i] = right[i + 1];
        }
    }

    let maxScore = 0;
    for (let i = 0; i < n; i++) {
        let l = left[i];
        let r = right[i];
        let score = nums[i] * (r - l + 1);
        maxScore = Math.max(maxScore, score);
    }

    return maxScore;
}