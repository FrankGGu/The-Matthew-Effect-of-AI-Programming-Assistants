var maxScore = function(nums, x) {
    // Initialize max scores for paths ending with an even number and an odd number.
    // Use Number.MIN_SAFE_INTEGER to represent negative infinity, ensuring arithmetic operations
    // result in sufficiently small negative numbers that Math.max can correctly handle.
    let maxScoreEndingEven = Number.MIN_SAFE_INTEGER;
    let maxScoreEndingOdd = Number.MIN_SAFE_INTEGER;

    // Process the first element nums[0]. It is always visited.
    if (nums[0] % 2 === 0) {
        maxScoreEndingEven = nums[0];
    } else {
        maxScoreEndingOdd = nums[0];
    }

    // Iterate through the array starting from the second element.
    for (let i = 1; i < nums.length; i++) {
        const num = nums[i];
        const isCurrentNumEven = num % 2 === 0;

        // Store the current max scores before they are potentially updated for this 'num'.
        // This is crucial because updates for 'maxScoreEndingEven' and 'maxScoreEndingOdd'
        // for the current step depend on the values from the *previous* step.
        const prevMaxScoreEndingEven = maxScoreEndingEven;
        const prevMaxScoreEndingOdd = maxScoreEndingOdd;

        // Calculate potential scores if we *choose to visit* the current 'num'.
        // These will be used to update maxScoreEndingEven or maxScoreEndingOdd.
        let scoreIfVisitCurrentNumAndEndsEven = Number.MIN_SAFE_INTEGER;
        let scoreIfVisitCurrentNumAndEndsOdd = Number.MIN_SAFE_INTEGER;

        if (isCurrentNumEven) {
            // If the current number is even:
            // 1. Path ends with a previous even number, now extends with current even num (no penalty).
            // 2. Path ends with a previous odd number, now extends with current even num (with penalty x).
            // The resulting path will end with an even number.
            scoreIfVisitCurrentNumAndEndsEven = Math.max(
                prevMaxScoreEndingEven !== Number.MIN_SAFE_INTEGER ? prevMaxScoreEndingEven + num : Number.MIN_SAFE_INTEGER,
                prevMaxScoreEndingOdd !== Number.MIN_SAFE_INTEGER ? prevMaxScoreEndingOdd + num - x : Number.MIN_SAFE_INTEGER
            );
            // Since `num` is even, it cannot be the end of an odd path if visited.
            // `scoreIfVisitCurrentNumAndEndsOdd` remains MIN_SAFE_INTEGER.
        } else { // currentNum is odd
            // If the current number is odd:
            // 1. Path ends with a previous odd number, now extends with current odd num (no penalty).
            // 2. Path ends with a previous even number, now extends with current odd num (with penalty x).
            // The resulting path will end with an odd number.
            scoreIfVisitCurrentNumAndEndsOdd = Math.max(
                prevMaxScoreEndingOdd !== Number.MIN_SAFE_INTEGER ? prevMaxScoreEndingOdd + num : Number.MIN_SAFE_INTEGER,
                prevMaxScoreEndingEven !== Number.MIN_SAFE_INTEGER ? prevMaxScoreEndingEven + num - x : Number.MIN_SAFE_INTEGER
            );
            // Since `num` is odd, it cannot be the end of an even path if visited.
            // `scoreIfVisitCurrentNumAndEndsEven` remains MIN_SAFE_INTEGER.
        }

        // Update `maxScoreEndingEven` and `maxScoreEndingOdd` for the state *after* considering `nums[i]`.
        // For `maxScoreEndingEven`: it can either remain `prevMaxScoreEndingEven` (if we don't visit `nums[i]`, or if `nums[i]` is odd and thus doesn't extend an even path)
        //                         OR it can become `scoreIfVisitCurrentNumAndEndsEven` (if we visit `nums[i]` and it's even).
        maxScoreEndingEven = Math.max(prevMaxScoreEndingEven, scoreIfVisitCurrentNumAndEndsEven);

        // For `maxScoreEndingOdd`: it can either remain `prevMaxScoreEndingOdd` (if we don't visit `nums[i]`, or if `nums[i]` is even and thus doesn't extend an odd path)
        //                        OR it can become `scoreIfVisitCurrentNumAndEndsOdd` (if we visit `nums[i]` and it's odd).
        maxScoreEndingOdd = Math.max(prevMaxScoreEndingOdd, scoreIfVisitCurrentNumAndEndsOdd);
    }

    // The final answer is the maximum of the two possible ending states (ending with an even or an odd number).
    return Math.max(maxScoreEndingEven, maxScoreEndingOdd);
};