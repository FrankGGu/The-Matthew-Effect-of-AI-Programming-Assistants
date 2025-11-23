var wiggleSort = function(nums) {
    const n = nums.length;

    const sortedNums = [...nums].sort((a, b) => a - b);

    let i = Math.floor((n - 1) / 2);
    let j = n - 1;

    for (let k = 0; k < n; k++) {
        if (k % 2 === 0) {
            nums[k] = sortedNums[i--];
        } else {
            nums[k] = sortedNums[j--];
        }
    }
};