var wiggleMaxLength = function(nums) {
    const n = nums.length;
    if (n < 2) {
        return n;
    }

    let count = 1;
    let prevDiff = 0; // 0 indicates no previous significant difference or a flat segment

    for (let i = 1; i < n; i++) {
        const currDiff = nums[i] - nums[i - 1];

        // If current difference is positive and the previous trend was non-positive (flat or decreasing)
        // This marks a new upward wiggle segment.
        if (currDiff > 0 && prevDiff <= 0) {
            count++;
            prevDiff = currDiff;
        }
        // If current difference is negative and the previous trend was non-negative (flat or increasing)
        // This marks a new downward wiggle segment.
        else if (currDiff < 0 && prevDiff >= 0) {
            count++;
            prevDiff = currDiff;
        }
        // If currDiff is 0, it does not change the trend, so we do nothing.
        // If currDiff has the same sign as prevDiff, it's a continuation of the same trend,
        // so we do nothing (e.g., 1, 7, 9 - 9 continues the upward trend from 1 to 7).
        // The prevDiff is kept, effectively "waiting" for a change in direction.
    }

    return count;
};