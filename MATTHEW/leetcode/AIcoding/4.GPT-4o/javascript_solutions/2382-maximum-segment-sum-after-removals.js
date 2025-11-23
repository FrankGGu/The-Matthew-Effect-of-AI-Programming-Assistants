var maximumSegmentSum = function(nums, remove) {
    const n = nums.length;
    const removed = new Set(remove);
    const sumSegment = [];
    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        if (!removed.has(i)) {
            let currentSum = 0;
            while (i < n && !removed.has(i)) {
                currentSum += nums[i];
                i++;
            }
            sumSegment.push(currentSum);
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};