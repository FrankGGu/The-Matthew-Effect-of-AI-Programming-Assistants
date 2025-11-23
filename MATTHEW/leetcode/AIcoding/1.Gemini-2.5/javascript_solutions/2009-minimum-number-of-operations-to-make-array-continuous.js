var minOperations = function(nums) {
    const n = nums.length;
    let minOps = n;

    nums.sort((a, b) => a - b);

    const uniqueNums = [];
    if (n > 0) {
        uniqueNums.push(nums[0]);
        for (let i = 1; i < n; i++) {
            if (nums[i] !== nums[i - 1]) {
                uniqueNums.push(nums[i]);
            }
        }
    }

    const m = uniqueNums.length;

    let j = 0;
    for (let i = 0; i < m; i++) {
        while (j < m && uniqueNums[j] < uniqueNums[i] + n) {
            j++;
        }

        minOps = Math.min(minOps, n - (j - i));
    }

    return minOps;
};