var minimumDeletions = function(nums) {
    const n = nums.length;
    let minIndex = 0;
    let maxIndex = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] < nums[minIndex]) {
            minIndex = i;
        }
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    const a = Math.max(minIndex, maxIndex) + 1;
    const b = n - Math.min(minIndex, maxIndex);
    const c = Math.min(minIndex, maxIndex) + 1 + (n - Math.max(minIndex, maxIndex));

    return Math.min(a, b, c);
};