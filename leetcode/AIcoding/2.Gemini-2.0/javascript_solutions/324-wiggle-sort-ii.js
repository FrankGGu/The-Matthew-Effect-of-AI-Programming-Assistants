var wiggleSort = function(nums) {
    const n = nums.length;
    const sortedNums = [...nums].sort((a, b) => a - b);
    let j = n - 1;
    for (let i = 1; i < n; i += 2) {
        nums[i] = sortedNums[j];
        j--;
    }
    for (let i = 0; i < n; i += 2) {
        nums[i] = sortedNums[j];
        j--;
    }
};