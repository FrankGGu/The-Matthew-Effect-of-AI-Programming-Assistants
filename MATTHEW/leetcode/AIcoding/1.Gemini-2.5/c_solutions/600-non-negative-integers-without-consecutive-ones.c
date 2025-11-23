#include <stdbool.h> // For bool type

int findIntegers(int n) {
    // dp[i] stores the count of binary strings of length i without consecutive ones.
    // dp[0] = 1 (represents an empty string, or the single number 0)
    // dp[1] = 2 (represents "0" and "1" as strings of length 1)
    // For i >= 2, dp[i] = dp[i-1] + dp[i-2].
    // This is because a valid string of length i can either:
    // 1. End with '0': The first i-1 bits can be any valid string (dp[i-1] ways).
    // 2. End with '1': The (i-1)-th bit MUST be '0' to avoid "11". The first i-2 bits
    //    can be any valid string (dp[i-2] ways).
    // Max n is 10^9, which is less than 2^30. So we need to consider up to 30 bits (indices 0 to 29).
    // An array size of 31 is sufficient to store dp values up to dp[30].
    int dp[31];
    dp[0] = 1; // Count for length 0 (empty string)
    dp[1] = 2; // Count for length 1 ("0", "1")
    for (int i = 2; i < 31; ++i) {
        dp[i] = dp[i-1] + dp[i-2];
    }

    int ans = 0;
    bool prev_bit_is_one = false; // Tracks if the previous bit of 'n' was 1
    bool n_is_valid = true;       // Tracks if 'n' itself has consecutive ones

    // Iterate from the most significant bit (MSB) down to the least significant bit (LSB).
    // The highest possible bit for a number up to 10^9 is bit 29.
    // (2^29 = 536,870,912, 2^30 = 1,073,741,824).
    for (int i = 29; i >= 0; --i) {
        // Check if the i-th bit of 'n' is 1
        if ((n >> i) & 1) {
            // If the i-th bit of 'n' is 1, we can form numbers that are smaller than 'n'
            // by setting this i-th bit to 0.
            // The prefix (bits from MSB down to i+1) is fixed to match 'n'.
            // The current i-th bit is set to 0.
            // The remaining 'i' bits (from i-1 down to 0) can be any valid binary string
            // of length 'i' without consecutive ones. The count for this is dp[i].
            ans += dp[i];

            // Now, consider the path where the current i-th bit is 1 (matching 'n').
            // If the previous bit (i+1-th bit) of 'n' was also 1, then 'n' itself
            // contains consecutive ones (...11...).
            // In this scenario, any number with the current prefix (which includes ...11...)
            // will be invalid. We have already added numbers with 0 at the current position.
            // We cannot proceed further by matching 'n's 1 at this position, because it
            // would create an invalid prefix. So, we mark 'n' as invalid and stop.
            if (prev_bit_is_one) {
                n_is_valid = false;
                break;
            }
            // If no consecutive ones yet, set prev_bit_is_one to true for the next iteration
            // (as the current bit of 'n' is 1).
            prev_bit_is_one = true;
        } else {
            // If the i-th bit of 'n' is 0, we cannot form numbers by setting this bit to 1
            // (because that would make the number larger than 'n').
            // We just continue by matching 'n's 0 at this bit.
            // Reset prev_bit_is_one to false.
            prev_bit_is_one = false;
        }
    }

    // After the loop, if 'n_is_valid' is still true, it means 'n' itself does not have
    // consecutive ones in its binary representation.
    // 'n' was not explicitly counted in the loop (the loop counts numbers strictly less than 'n'
    // for prefixes that match 'n' and then diverge). So, we add 'n' itself to the count.
    if (n_is_valid) {
        ans++;
    }

    return ans;
}