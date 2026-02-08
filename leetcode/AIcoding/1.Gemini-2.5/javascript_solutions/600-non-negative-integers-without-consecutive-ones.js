var findIntegers = function(n) {
    // dp[i] stores the count of binary strings of length i without consecutive ones.
    // dp[0] = 1 (represents an empty string, or the number 0 with 0 bits)
    // dp[1] = 2 (represents "0", "1")
    // dp[i] = dp[i-1] + dp[i-2] for i >= 2 (Fibonacci sequence relationship)
    // For example:
    // dp[0] = 1
    // dp[1] = 2
    // dp[2] = dp[1] + dp[0] = 2 + 1 = 3 (00, 01, 10)
    // dp[3] = dp[2] + dp[1] = 3 + 2 = 5 (000, 001, 010, 100, 101)

    // Max n is 10^9, which is less than 2^30. So, max binary length is 30 bits.
    // We need dp up to index 29 (for L=30, L-1-i can be 29).
    // Array size 32 is sufficient for indices 0 to 31.
    const dp = new Array(32); 
    dp[0] = 1;
    dp[1] = 2;
    for (let i = 2; i < 32; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }

    // Convert n to its binary string representation
    const s = n.toString(2);
    const L = s.length;
    let count = 0;
    let prevBitWasOne = false; // Tracks if the previous bit processed was '1'
    let nIsValid = true;       // Flag to check if n itself contains consecutive ones

    // Iterate from MSB (most significant bit) to LSB (least significant bit)
    for (let i = 0; i < L; i++) {
        const currentBit = parseInt(s[i]); // Get the current bit of n

        if (currentBit === 1) {
            // If the current bit of n is '1':
            // We can form numbers smaller than n by placing a '0' at this position.
            // The prefix s[0...i-1] is fixed.
            // The i-th bit is '0'.
            // The remaining (L - 1 - i) bits can be any valid binary string without consecutive ones.
            // The count of such valid strings is dp[L - 1 - i].
            count += dp[L - 1 - i];

            // Check if n itself has consecutive ones (e.g., "11") up to this point
            if (prevBitWasOne) {
                // If n has "11" as a prefix, then n itself is invalid.
                // Any numbers formed by extending this "11" prefix would also be invalid.
                // We've already counted all valid numbers that are strictly smaller than n
                // by placing '0' at this position. So we can stop further processing for n's path.
                nIsValid = false; // Mark n as invalid
                break;            // Exit the loop
            }
            prevBitWasOne = true; // Set flag for the next iteration
        } else { // currentBit === 0
            prevBitWasOne = false; // Reset flag
        }
    }

    // After the loop, `count` holds the number of valid integers strictly less than n.
    // If `nIsValid` is true, it means n itself does not have consecutive ones
    // (i.e., the loop completed without breaking due to "11").
    // In this case, n is a valid number, and we need to add 1 to include it in the total count.
    if (nIsValid) {
        count++;
    }

    return count;
};