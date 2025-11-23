var maxSubsequence = function(nums, k) {
    const indexedNums = nums.map((num, index) => ({ num, index }));
    indexedNums.sort((a, b) => b.num - a.num);
    const selected = indexedNums.slice(0, k);
    selected.sort((a, b) => a.index - b.index);
    return selected.map(item => item.num);
};