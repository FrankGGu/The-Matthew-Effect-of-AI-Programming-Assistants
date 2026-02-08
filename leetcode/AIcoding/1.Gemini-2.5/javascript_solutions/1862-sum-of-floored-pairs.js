var sumOfFlooredPairs = function(nums) {
    const MOD = 10 ** 9 + 7;
    const MAX_VAL = 100000; // Maximum possible value for nums[i]

    // Step 1: Count frequencies of each number in nums
    // counts[x] will store how many times x appears in nums
    const counts = new Array(MAX_VAL + 1).fill(0);
    for (const num of nums) {
        counts[num]++;
    }

    // Step 2: Create a prefix sum array for counts
    // prefixCounts[i] will store the total count of numbers less than or equal to i
    const prefixCounts = new Array(MAX_VAL + 1).fill(0);
    prefixCounts[0] = 0; 
    for (let i = 1; i <= MAX_VAL; i++) {
        prefixCounts[i] = prefixCounts[i - 1] + counts[i];
    }

    let totalSum = 0;

    // Iterate through all possible denominators 'y' (from 1 to MAX_VAL)
    // 'y' represents a value that could be nums[j]
    for (let y = 1; y <= MAX_VAL; y++) {
        // If 'y' does not appear in the input array 'nums', it cannot be a denominator,
        // so we skip it to optimize.
        if (counts[y] === 0) {
            continue;
        }

        // Calculate the sum of floor(x / y) for all x in nums, where x is nums[i]
        // This is equivalent to sum_{x=1 to MAX_VAL} (counts[x] * floor(x / y))
        let currentYSum = 0;

        // Iterate through all possible quotients 'k' that floor(x / y) can take
        // 'k' can range from 1 up to MAX_VAL / y
        for (let k = 1; k * y <= MAX_VAL; k++) {
            // For a fixed 'y' and 'k', we are looking for numbers 'x' such that floor(x / y) = k.
            // This means k * y <= x < (k + 1) * y.
            // The range of 'x' is [lowerBound, upperBound].
            const lowerBound = k * y;
            const upperBound = (k + 1) * y - 1;

            // Count how many numbers from the original 'nums' array fall into this range [lowerBound, upperBound].
            // We use the prefixCounts array for efficient range sum query.
            // The upper bound for x cannot exceed MAX_VAL.
            const numElementsInRange = prefixCounts[Math.min(MAX_VAL, upperBound)] - prefixCounts[lowerBound - 1];

            // Add k multiplied by the count of numbers in this range to currentYSum.
            // All numbers 'x' in this range contribute 'k' to floor(x / y).
            currentYSum = (currentYSum + k * numElementsInRange) % MOD;
        }

        // Since 'y' appears counts[y] times in the input array,
        // the `currentYSum` (which represents sum of floor(x/y) for a single y)
        // must be multiplied by `counts[y]` and added to the total sum.
        totalSum = (totalSum + counts[y] * currentYSum) % MOD;
    }

    return totalSum;
};