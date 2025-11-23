var largestCombination = function(candidates) {
    let maxCombinationSize = 0;

    // Iterate through each bit position from 0 to 30 (as numbers are up to 10^7, which fits within 24 bits, but 30 is a safe upper bound for standard integers)
    for (let i = 0; i < 31; i++) {
        let currentBitSetCount = 0;
        // For each bit position, count how many numbers in the candidates array have this bit set
        for (const num of candidates) {
            // Check if the i-th bit of 'num' is set
            if ((num >> i) & 1) {
                currentBitSetCount++;
            }
        }
        // Update the maximum combination size found so far
        maxCombinationSize = Math.max(maxCombinationSize, currentBitSetCount);
    }

    return maxCombinationSize;
};