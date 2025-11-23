var distinctDifferenceArray = function(nums) {
    const n = nums.length;
    const diff = new Array(n);

    for (let i = 0; i < n; i++) {
        const prefixSet = new Set();
        for (let j = 0; j <= i; j++) {
            prefixSet.add(nums[j]);
        }
        const prefixDistinctCount = prefixSet.size;

        const suffixSet = new Set();
        for (let j = i + 1; j < n; j++) {
            suffixSet.add(nums[j]);
        }
        const suffixDistinctCount = suffixSet.size;

        diff[i] = Math.abs(prefixDistinctCount - suffixDistinctCount);
    }

    return diff;
};