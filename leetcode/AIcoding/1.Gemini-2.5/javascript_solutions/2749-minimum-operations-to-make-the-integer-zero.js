var minimumOperations = function(n, k) {
    // We are looking for the minimum number of operations, 'x'.
    // In 'x' operations, we subtract 'k' 'x' times, totaling 'x * k'.
    // Additionally, in each operation, we subtract a power of two (2^i).
    // So, after 'x' operations, 'n' becomes n - (sum of x powers of two) - (x * k).
    // We want this to be zero: n - (sum of x powers of two) - (x * k) = 0.
    // This implies: n - x * k = sum of x powers of two.

    // Let 'rem' be the value n - x * k.
    // We need to find the smallest 'x' (number of operations) such that 'rem' can be represented as the sum of 'x' powers of two.
    // For 'rem' to be representable as a sum of 'x' powers of two, the following conditions must hold:
    // 1. 'rem' must be non-negative. (Since powers of two are positive, their sum must be non-negative).
    // 2. 'rem' must be at least 'x'. (Each power of two (2^i) is at least 2^0 = 1. So, the sum of 'x' powers of two must be at least 'x').
    // 3. The number of set bits in the binary representation of 'rem' (popcount(rem)) must be less than or equal to 'x'.
    //    This is because 'popcount(rem)' represents the minimum number of powers of two required to sum to 'rem'.
    //    If 'x' is greater than 'popcount(rem)', we can always decompose larger powers of two into smaller ones (e.g., 2^p = 2^(p-1) + 2^(p-1))
    //    until we have exactly 'x' powers of two.

    // Combining conditions: popcount(rem) <= x <= rem.
    // Also, 'rem' must be strictly positive. If 'rem' were 0, then popcount(0)=0. The condition 0 <= x <= 0 would imply x=0.
    // However, 'x' must be at least 1 (since we are performing operations).
    // The condition 'x <= rem' implies 'rem >= x >= 1', which means 'rem' is strictly positive, so this covers it.

    // We iterate 'x' (number of operations) starting from 1.
    // The maximum value for popcount(rem) for 'rem' up to 10^9 (approx 2^30) is 30.
    // This means if 'x' is, for example, 31 or greater, the condition 'popcount(rem) <= x' will always be true.
    // Therefore, if a solution 'x_ans' exists and 'x_ans > 30', it must be the smallest 'x' such that 'x <= rem'.
    // This implies 'x <= n - x * k', which simplifies to 'x * (k + 1) <= n', or 'x <= n / (k + 1)'.
    // If the answer is indeed greater than 30, it implies that for all 'x' from 1 to 30, either 'rem < x' or 'popcount(rem) > x'.
    // The maximum value 'x' can take while still being relevant for the 'popcount' check is small (around 30-40).
    // A loop bound of 60 is a safe upper limit to find the minimum 'x'.

    for (let x = 1; x <= 60; x++) { 
        let rem = n - x * k;

        // Condition check: rem must be at least x.
        // If 'rem < x', it means 'n - x * k' is too small to be a sum of 'x' positive powers of two.
        // Since 'n - x * k' decreases as 'x' increases, and 'x' increases, this condition will hold for all larger 'x' values.
        // So, we can stop searching.
        if (rem < x) {
            break;
        }

        // Calculate popcount (number of set bits) for 'rem'.
        let popcount = 0;
        let tempRem = rem;
        while (tempRem > 0) {
            popcount += (tempRem & 1); // Add 1 if the least significant bit is 1
            tempRem >>= 1;             // Right shift to check the next bit
        }

        // Condition check: popcount(rem) must be less than or equal to x.
        if (popcount <= x) {
            // If both conditions (x <= rem and popcount <= x) are met, we found a valid 'x'.
            // Since we are iterating 'x' upwards, this is the minimum 'x'.
            return x;
        }
    }

    // If the loop finishes without returning, it means no solution was found within the tested range.
    // According to typical LeetCode problem patterns, this implies no solution exists for the given inputs.
    // For example, if n=1, k=1, then rem=0 for x=1, and rem < x (0 < 1) breaks the loop, returning -1.
    return -1;
};