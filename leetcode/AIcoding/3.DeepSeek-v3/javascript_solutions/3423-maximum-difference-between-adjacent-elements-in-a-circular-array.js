var maxDifference = function(nums) {
    let maxDiff = -1;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        const current = nums[i];
        let nextIndex = (i + 1) % n;
        let next = nums[nextIndex];

        if (current < next) {
            maxDiff = Math.max(maxDiff, next - current);
        }
    }

    return maxDiff;
};