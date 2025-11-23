var numDupDigitsAtMostN = function(N) {
    // Helper function to calculate permutations P(n, k)
    // P(n, k) = n * (n-1) * ... * (n-k+1)
    function P(n, k) {
        if (k < 0 || k > n) return 0;
        let res = 1;
        for (let i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }

    // Convert N to a string to easily access digits
    const S = String(N);
    const L = S.length; // Number of digits in N

    let countNoRepeatedDigits = 0;

    // Part 1: Count numbers with no repeated digits that have fewer digits than N.
    // For k-digit numbers (1 <= k < L):
    // The first digit can be 1-9 (9 choices).
    // The remaining k-1 digits must be chosen from the remaining 9 distinct digits (0-9 excluding the first digit).
    for (let k = 1; k < L; k++) {
        countNoRepeatedDigits += 9 * P(9, k - 1);
    }

    // Part 2: Count numbers with no repeated digits that have L digits and are <= N.
    const seen = new Array(10).fill(false); // To keep track of digits used in the current prefix
    let is_N_distinct = true; // Flag to check if N itself has repeated digits
    let seen_count = 0; // Number of distinct digits already used in the prefix S[0]...S[i-1]

    for (let i = 0; i < L; i++) {
        const digit_N = parseInt(S[i]);

        // Iterate through possible digits 'j' for the current position 'i'
        // 'j' ranges from (1 if it's the first digit, to avoid leading zeros) to (digit_N - 1).
        for (let j = (i === 0 ? 1 : 0); j < digit_N; j++) {
            if (!seen[j]) {
                // If 'j' has not been seen in the current prefix, we can form a valid number.
                // The remaining L - 1 - i positions need to be filled with distinct digits.
                // The number of available digits for these remaining positions is:
                // 10 (total digits) - seen_count (digits used in S[0]...S[i-1]) - 1 (for digit 'j').
                countNoRepeatedDigits += P(10 - seen_count - 1, L - 1 - i);
            }
        }

        // After trying digits smaller than digit_N, we consider digit_N itself for the current position.
        // If digit_N has already been seen in the prefix S[0]...S[i-1],
        // it means N itself (and any number starting with this prefix) has repeated digits.
        // In this case, we cannot form any more numbers with no repeated digits using this prefix,
        // so we break the loop.
        if (seen[digit_N]) {
            is_N_distinct = false;
            break;
        }

        // Mark digit_N as seen and increment the count of distinct digits.
        seen[digit_N] = true;
        seen_count++;
    }

    // If the loop completed without breaking, it means N itself has no repeated digits.
    // In this case, N should be included in the count of numbers with no repeated digits.
    if (is_N_distinct) {
        countNoRepeatedDigits += 1;
    }

    // The problem asks for numbers with repeated digits.
    // This is equal to (Total numbers up to N) - (Numbers with no repeated digits up to N).
    return N - countNoRepeatedDigits;
};