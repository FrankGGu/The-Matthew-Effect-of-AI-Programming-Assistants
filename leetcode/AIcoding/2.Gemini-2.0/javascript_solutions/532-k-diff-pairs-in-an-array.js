var findPairs = function(nums, k) {
    let count = 0;
    const seen = new Set();
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            const diff = Math.abs(nums[i] - nums[j]);
            if (diff === k) {
                const pair = [Math.min(nums[i], nums[j]), Math.max(nums[i], nums[j])].join(',');
                if (!seen.has(pair)) {
                    count++;
                    seen.add(pair);
                }
            }
        }
    }
    return count;
};