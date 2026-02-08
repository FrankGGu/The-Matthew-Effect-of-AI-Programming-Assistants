var findShortestSubArray = function(nums) {
    const counts = {};
    const firstOccurrence = {};
    const lastOccurrence = {};

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        counts[num] = (counts[num] || 0) + 1;
        if (firstOccurrence[num] === undefined) {
            firstOccurrence[num] = i;
        }
        lastOccurrence[num] = i;
    }

    let degree = 0;
    for (const num in counts) {
        if (counts[num] > degree) {
            degree = counts[num];
        }
    }

    let minLength = nums.length;

    for (const num in counts) {
        if (counts[num] === degree) {
            const length = lastOccurrence[num] - firstOccurrence[num] + 1;
            if (length < minLength) {
                minLength = length;
            }
        }
    }

    return minLength;
};