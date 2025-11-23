var maximumLength = function(nums) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let maxLen = 0;

    // Handle the case for number 1 separately
    // If 1 is in the subset, 1*1=1 must also be in the subset. This condition is always met.
    // So, all occurrences of 1 can form a valid chain of any length.
    if (freq.has(1)) {
        maxLen = freq.get(1);
        freq.delete(1); // Remove 1 to avoid re-processing in the main loop
    }

    // Iterate through the remaining unique numbers
    // We only process numbers that haven't been part of a chain already.
    // This ensures we start from the "base" of a chain (e.g., for [2,4,16], we start with 2, not 4 or 16).
    for (const x of freq.keys()) {
        // If x has already been processed as part of another chain, skip it
        if (!freq.has(x)) {
            continue;
        }

        let currentChainLen = 0;
        let currentNum = x;

        // Traverse the chain x, x^2, x^4, ...
        // Add counts of all numbers in this chain that are present in nums.
        while (freq.has(currentNum)) {
            currentChainLen += freq.get(currentNum);
            freq.delete(currentNum); // Mark as processed to avoid re-counting

            // Calculate the next number in the chain.
            // If currentNum is large enough that its square exceeds 10^9 (max value in nums),
            // then the next number cannot be in nums. We can stop the chain here.
            // Math.sqrt(10^9) is approximately 31622.77.
            // If currentNum > 31622, then currentNum * currentNum will be > 10^9.
            if (currentNum > 31622) { 
                break;
            }

            currentNum *= currentNum;
        }
        maxLen = Math.max(maxLen, currentChainLen);
    }

    return maxLen;
};