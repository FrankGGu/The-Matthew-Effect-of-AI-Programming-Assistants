var distinctDifferenceArray = function(nums) {
    const n = nums.length;
    const result = new Array(n);
    const prefixSet = new Set();
    const suffixCount = new Map();

    for (const num of nums) {
        suffixCount.set(num, (suffixCount.get(num) || 0) + 1);
    }

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        prefixSet.add(num);
        suffixCount.set(num, suffixCount.get(num) - 1);
        if (suffixCount.get(num) === 0) {
            suffixCount.delete(num);
        }
        result[i] = prefixSet.size - suffixCount.size;
    }

    return result;
};