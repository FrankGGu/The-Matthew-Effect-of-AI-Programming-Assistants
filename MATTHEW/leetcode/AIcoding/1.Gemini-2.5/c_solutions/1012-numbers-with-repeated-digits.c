#include <stdbool.h>
#include <string.h> // For memset, though a loop is fine for bool array

int permutations(int n, int k) {
    if (k < 0 || k > n) {
        return 0;
    }
    if (k == 0) {
        return 1;
    }
    int res = 1;
    for (int i = 0; i < k; ++i) {
        res *= (n - i);
    }
    return res;
}

int numDupDigitsAtN(int N) {
    // Convert N to a list of its digits
    int digits[10]; // N <= 10^9, so max 10 digits
    int L = 0;
    int temp_N = N;

    // Extract digits in reverse order
    while (temp_N > 0) {
        digits[L++] = temp_N % 10;
        temp_N /= 10;
    }

    // Reverse the digits array to get MSB first
    for (int i = 0; i < L / 2; ++i) {
        int temp = digits[i];
        digits[i] = digits[L - 1 - i];
        digits[L - 1 - i] = temp;
    }

    int count_no_repeated = 0;

    // 1. Count numbers with no repeated digits that have fewer digits than N
    // For k-digit numbers (1 <= k < L)
    for (int k = 1; k < L; ++k) {
        // First digit can be 1-9 (9 choices)
        // Remaining k-1 digits from the remaining 9 available digits (0-9 excluding the first)
        count_no_repeated += 9 * permutations(9, k - 1);
    }

    // 2. Count numbers with no repeated digits that have the same number of digits as N (L digits) and are <= N
    bool used[10] = {false}; // Track used digits (0-9)
    bool N_itself_has_repeated = false; // Flag to check if N itself has repeated digits

    for (int i = 0; i < L; ++i) { // Iterate through digit positions from left to right (MSB to LSB)
        int d = digits[i]; // Current digit of N

        // Try to place a digit 'j' at current position 'i' such that 'j' < 'd'
        // and 'j' has not been used yet.
        // The first digit 'j' cannot be 0 if it's the most significant digit (i == 0)
        for (int j = (i == 0 ? 1 : 0); j < d; ++j) {
            if (!used[j]) {
                // If j is not used, we can form a valid number
                // The remaining L - (i + 1) positions can be filled with permutations
                // from the remaining 10 - (i + 1) available digits.
                count_no_repeated += permutations(10 - (i + 1), L - (i + 1));
            }
        }

        // Now, consider placing 'd' (the actual digit from N) at current position 'i'
        // Check if 'd' has already been used in the prefix
        if (used[d]) {
            N_itself_has_repeated = true; // N itself has repeated digits
            break; // Any number formed from here will have repeated digits
        }
        used[d] = true; // Mark 'd' as used for the current prefix
    }

    // If N itself has no repeated digits (loop completed without break),
    // then N is one of the numbers counted in 'count_no_repeated'.
    // We need to add 1 for N if it has no repeated digits.
    if (!N_itself_has_repeated) {
        count_no_repeated += 1;
    }

    // The result is total numbers up to N minus numbers with no repeated digits up to N.
    return N - count_no_repeated;
}