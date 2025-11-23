function findScore(nums) {
    const n = nums.length;
    const marked = new Array(n).fill(false);
    const indexedNums = nums.map((num, index) => [num, index]).sort((a, b) => a[0] - b[0]);
    let score = 0;

    for (const [num, index] of indexedNums) {
        if (!marked[index]) {
            score += num;
            marked[index] = true;
            if (index > 0) marked[index - 1] = true;
            if (index < n - 1) marked[index + 1] = true;
        }
    }

    return score;
}