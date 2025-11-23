function getMaxScoreIndices(nums) {
    const n = nums.length;
    const left = new Array(n + 1).fill(0);
    const right = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        left[i + 1] = left[i] + (nums[i] === 0 ? 1 : 0);
    }

    for (let i = n - 1; i >= 0; i--) {
        right[i] = right[i + 1] + (nums[i] === 1 ? 1 : 0);
    }

    let maxScore = 0;
    const result = [];

    for (let i = 0; i <= n; i++) {
        const score = left[i] + right[i];
        if (score > maxScore) {
            maxScore = score;
            result.length = 0;
            result.push(i);
        } else if (score === maxScore) {
            result.push(i);
        }
    }

    return result;
}