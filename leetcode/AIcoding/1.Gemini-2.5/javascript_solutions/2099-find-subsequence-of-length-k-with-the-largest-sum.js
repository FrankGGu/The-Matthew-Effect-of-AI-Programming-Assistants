var maxSubsequence = function(nums, k) {
    const indexedNums = [];
    for (let i = 0; i < nums.length; i++) {
        indexedNums.push({ value: nums[i], originalIndex: i });
    }

    indexedNums.sort((a, b) => b.value - a.value);

    const largestK = indexedNums.slice(0, k);

    largestK.sort((a, b) => a.originalIndex - b.originalIndex);

    const result = [];
    for (let i = 0; i < largestK.length; i++) {
        result.push(largestK[i].value);
    }

    return result;
};