var minimumIndex = function(nums) {
    const n = nums.length;
    const freq = {};
    let dominant = -1;

    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
        if (freq[num] * 2 > n) {
            dominant = num;
        }
    }

    let leftCount = 0;
    for (let i = 0; i < n - 1; i++) {
        if (nums[i] === dominant) {
            leftCount++;
        }
        const rightCount = freq[dominant] - leftCount;
        if (leftCount * 2 > (i + 1) && rightCount * 2 > (n - i - 1)) {
            return i;
        }
    }

    return -1;
};