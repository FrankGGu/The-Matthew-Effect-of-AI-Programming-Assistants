var longestConsecutive = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    const numSet = new Set(nums);
    let maxLength = 0;

    for (const num of numSet) { // Iterate through the set to avoid duplicates and for O(1) lookups
        // Check if the current number is the start of a sequence
        // A number 'num' is the start of a sequence if 'num - 1' is not in the set
        if (!numSet.has(num - 1)) {
            let currentNum = num;
            let currentLength = 1;

            // Increment currentNum and currentLength as long as consecutive numbers exist in the set
            while (numSet.has(currentNum + 1)) {
                currentNum++;
                currentLength++;
            }

            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};