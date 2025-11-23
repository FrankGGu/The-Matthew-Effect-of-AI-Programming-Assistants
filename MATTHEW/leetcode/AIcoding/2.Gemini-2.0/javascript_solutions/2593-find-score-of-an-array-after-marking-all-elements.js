var findScore = function(nums) {
    const n = nums.length;
    let score = 0;
    const marked = new Array(n).fill(false);
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums[a] - nums[b] || a - b);

    for (const i of indices) {
        if (!marked[i]) {
            score += nums[i];
            marked[i] = true;
            if (i > 0) marked[i - 1] = true;
            if (i < n - 1) marked[i + 1] = true;
        }
    }

    return score;
};