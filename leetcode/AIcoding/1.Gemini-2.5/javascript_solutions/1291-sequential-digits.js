var sequentialDigits = function(low, high) {
    const result = [];

    // Iterate through all possible starting digits (1 to 9)
    for (let i = 1; i <= 9; i++) {
        let currentNum = i;
        // Iterate through possible subsequent digits (from i+1 to 9)
        for (let j = i + 1; j <= 9; j++) {
            // Append the next digit to form a sequential number
            currentNum = currentNum * 10 + j;

            // Check if the generated number is within the specified range [low, high]
            if (currentNum >= low && currentNum <= high) {
                result.push(currentNum);
            }

            // Optimization: If currentNum already exceeds high,
            // any further sequential numbers built from it will also exceed high.
            // So, we can break the inner loop early.
            if (currentNum > high) {
                break;
            }
        }
    }

    // The problem requires the list to be sorted.
    // While the generation process ensures numbers with smaller starting digits
    // and shorter lengths are generated first, the overall order might not be strictly sorted
    // (e.g., 123 might be generated before 23 if low allows both).
    // Therefore, an explicit sort is necessary.
    result.sort((a, b) => a - b);

    return result;
};