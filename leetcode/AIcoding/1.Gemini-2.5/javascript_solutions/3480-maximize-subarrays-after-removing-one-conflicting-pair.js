var maximizeSubarraysAfterRemovingOneConflictingPair = function(nums, k) {
    let maxLength = 0;
    let freq = new Map();
    let numDuplicates = 0; // Counts distinct numbers that appear exactly twice
    let numTriplicates = 0; // Counts distinct numbers that appear three or more times

    let left = 0;
    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq.set(num, (freq.get(num) || 0) + 1);

        if (freq.get(num) === 2) {
            numDuplicates++;
        } else if (freq.get(num) === 3) {
            numDuplicates--; // This number is no longer just a duplicate, it's a triplicate
            numTriplicates++;
        }

        // The condition for a valid window is:
        // - No number appears three or more times (numTriplicates === 0)
        // - At most one number appears exactly twice (numDuplicates <= 1)
        while (numTriplicates > 0 || numDuplicates > 1) {
            const leftNum = nums[left];
            if (freq.get(leftNum) === 3) {
                numTriplicates--;
                numDuplicates++; // This number just went from triplicate to duplicate
            } else if (freq.get(leftNum) === 2) {
                numDuplicates--; // This number just went from duplicate to unique
            }
            freq.set(leftNum, freq.get(leftNum) - 1);
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};