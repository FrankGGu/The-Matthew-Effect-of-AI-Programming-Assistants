var maximumLength = function(nums, k) {
    const dp = new Map(); // Stores the maximum length of a valid subsequence ending with a specific number
    let maxLength = 0;

    for (const num of nums) {
        let currentLen = 1; // A subsequence of length 1 always exists (the number itself)

        // Condition 1: Check for previous element `num - k`
        const prevDiffVal = num - k;
        if (dp.has(prevDiffVal)) {
            currentLen = Math.max(currentLen, dp.get(prevDiffVal) + 1);
        }

        // Condition 2: Check for previous elements that are divisors of `num`
        // Iterate through potential divisors from 1 up to sqrt(num)
        for (let d = 1; d * d <= num; d++) {
            if (num % d === 0) {
                // `d` is a divisor
                if (dp.has(d)) {
                    currentLen = Math.max(currentLen, dp.get(d) + 1);
                }

                // `num / d` is also a divisor
                const d2 = num / d;
                if (d2 !== d) { // Avoid double counting if num is a perfect square (e.g., d=sqrt(num))
                    if (dp.has(d2)) {
                        currentLen = Math.max(currentLen, dp.get(d2) + 1);
                    }
                }
            }
        }

        // Update dp with the maximum length of a valid subsequence ending with the current 'num'.
        // If 'num' has appeared before, we update its entry if the current subsequence is longer.
        // This handles cases with duplicate numbers correctly, extending subsequences.
        dp.set(num, Math.max(dp.get(num) || 0, currentLen));

        // Update the overall maximum length found so far
        maxLength = Math.max(maxLength, currentLen);
    }

    return maxLength;
};