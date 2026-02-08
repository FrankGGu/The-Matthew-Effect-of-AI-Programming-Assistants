var minOperations = function(nums) {
    const n = nums.length;
    const uniqueSorted = [...new Set(nums)].sort((a, b) => a - b);
    let minOps = n;
    let left = 0;

    for (let right = 0; right < uniqueSorted.length; right++) {
        while (uniqueSorted[right] - uniqueSorted[left] >= n) {
            left++;
        }
        minOps = Math.min(minOps, n - (right - left + 1));
    }

    return minOps;
};