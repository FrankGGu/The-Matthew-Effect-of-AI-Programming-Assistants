var findScore = function(nums) {
    const n = nums.length;
    const indexedNums = [];
    for (let i = 0; i < n; i++) {
        indexedNums.push({ val: nums[i], originalIdx: i });
    }

    indexedNums.sort((a, b) => a.val - b.val);

    let score = 0;
    const marked = new Array(n).fill(false);

    for (const { val, originalIdx } of indexedNums) {
        if (!marked[originalIdx]) {
            score += val;
            marked[originalIdx] = true;

            if (originalIdx > 0) {
                marked[originalIdx - 1] = true;
            }
            if (originalIdx < n - 1) {
                marked[originalIdx + 1] = true;
            }
        }
    }

    return score;
};