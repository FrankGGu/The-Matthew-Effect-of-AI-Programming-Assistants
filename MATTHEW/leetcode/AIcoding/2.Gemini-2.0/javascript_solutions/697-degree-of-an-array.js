var findShortestSubArray = function(nums) {
    const counts = {};
    const firstOccurrence = {};
    const lastOccurrence = {};

    let degree = 0;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (!counts[num]) {
            counts[num] = 0;
            firstOccurrence[num] = i;
        }
        counts[num]++;
        lastOccurrence[num] = i;
        degree = Math.max(degree, counts[num]);
    }

    let minLength = nums.length;
    for (const num in counts) {
        if (counts[num] === degree) {
            minLength = Math.min(minLength, lastOccurrence[num] - firstOccurrence[num] + 1);
        }
    }

    return minLength;
};