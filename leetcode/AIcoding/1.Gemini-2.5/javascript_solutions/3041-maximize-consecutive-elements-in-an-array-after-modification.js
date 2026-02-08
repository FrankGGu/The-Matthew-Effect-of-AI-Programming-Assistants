var maximizeConsecutive = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    const uniqueNums = [...new Set(nums)].sort((a, b) => a - b);
    const n = uniqueNums.length;

    let left = 0;
    let maxLen = 0;

    for (let right = 0; right < n; right++) {
        // Calculate the number of missing integers (gaps) within the current window
        // [uniqueNums[left], ..., uniqueNums[right]].
        // The ideal length of a consecutive sequence from uniqueNums[left] to uniqueNums[right]
        // would be (uniqueNums[right] - uniqueNums[left] + 1).
        // The actual number of elements in the window is (right - left + 1).
        // The difference gives the number of gaps.
        let numGaps = (uniqueNums[right] - uniqueNums[left]) - (right - left);

        // If there are more than one gap, we cannot fill them all with a single modification.
        // We need to shrink the window from the left until we have at most one gap.
        while (numGaps > 1 && left < right) {
            left++;
            numGaps = (uniqueNums[right] - uniqueNums[left]) - (right - left);
        }

        // At this point, the window [left, right] contains elements that, with at most one modification,
        // can form a consecutive sequence.
        // (right - left + 1) is the count of distinct elements in the current window.
        // We add 1 because we have one modification available:
        // - If numGaps is 0 (window is already consecutive), we can extend the sequence by 1.
        // - If numGaps is 1 (one gap in the window), we can fill that gap.
        // In both scenarios, the resulting consecutive sequence length is (current elements count) + 1.
        maxLen = Math.max(maxLen, (right - left + 1) + 1);
    }

    return maxLen;
};