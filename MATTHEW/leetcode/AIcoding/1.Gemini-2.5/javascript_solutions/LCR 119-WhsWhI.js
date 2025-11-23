var longestConsecutive = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    const numSet = new Set(nums);
    let maxLength = 0;

    for (const num of nums) {
        // Check if the current number is the start of a sequence
        // (i.e., num - 1 is not in the set)
        if (!numSet.has(num - 1)) {
            let currentNum = num;
            let currentLength = 1;

            // Extend the sequence upwards
            while (numSet.has(currentNum + 1)) {
                currentNum++;
                currentLength++;
            }

            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};