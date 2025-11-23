var wiggleSort = function(nums) {
    const sorted = [...nums].sort((a, b) => a - b);
    const n = nums.length;
    const mid = Math.floor((n + 1) / 2);
    let i = mid - 1, j = n - 1, k = 0;

    while (k < n) {
        nums[k++] = sorted[i--];
        if (k < n) {
            nums[k++] = sorted[j--];
        }
    }
};