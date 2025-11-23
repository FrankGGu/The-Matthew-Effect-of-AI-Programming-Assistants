var minimumDeletions = function(nums) {
    const n = nums.length;
    if (n <= 2) return n;

    let minIndex = 0;
    let maxIndex = 0;

    for (let i = 1; i < n; i++) {
        if (nums[i] < nums[minIndex]) minIndex = i;
        if (nums[i] > nums[maxIndex]) maxIndex = i;
    }

    const left = Math.min(minIndex, maxIndex) + 1;
    const right = Math.max(minIndex, maxIndex) + 1;
    const both = Math.min(n - minIndex, n - maxIndex) + 1;

    return Math.min(left + right - 1, both);
};