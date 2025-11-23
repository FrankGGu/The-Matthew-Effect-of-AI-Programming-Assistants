#include <stdbool.h>
#include <stdlib.h> // For qsort
#include <string.h> // For memset

#define MAX_BALANCED_NUMBERS_CAPACITY 100 
static int balancedNumbers[MAX_BALANCED_NUMBERS_CAPACITY];
static int balancedCount = 0;
static bool precomputed_flag = false;

static int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

static void generatePermutations(int* digits_to_permute, int length, int current_index, long long current_num, bool* used) {
    if (current_index == length) {
        // Check against INT_MAX (2147483647) and ensure it's positive
        if (current_num <= 2147483647LL && current_num > 0) { 
            balancedNumbers[balancedCount++] = (int)current_num;
        }
        return;
    }

    for (int i = 0; i < length; ++i) {
        if (used[i]) continue;

        // Optimization to avoid duplicate permutations when digits_to_permute has duplicates
        // This requires digits_to_permute to be sorted before calling generatePermutations.
        if (i > 0 && digits_to_permute[i] == digits_to_permute[i-1] && !used[i-1]) {
            continue;
        }

        used[i] = true;
        generatePermutations(digits_to_permute, length, current_index + 1, current_num * 10 + digits_to_permute[i], used);
        used[i] = false;
    }
}

static void chooseDigits(int digit_val, int current_length, int* chosen_digits_counts) {
    // The maximum length for a balanced number that fits in an int is 10 (e.g., 1999999999).
    if (current_length > 10) {
        return;
    }
    if (digit_val == 10) { // All digits from 1 to 9 have been considered
        if (current_length > 0) { // We must have chosen at least one digit
            // Construct the flat array of digits for permutation
            int digits_to_permute[10]; // Max 10 digits
            int permute_length = 0;
            for (int d = 1; d <= 9; ++d) {
                for (int i = 0; i < chosen_digits_counts[d]; ++i) {
                    digits_to_permute[permute_length++] = d;
                }
            }

            // Sort the digits_to_permute array for the permutation optimization
            qsort(digits_to_permute, permute_length, sizeof(int), compareInts);

            bool used[10]; // Max 10 digits, so 10 booleans
            memset(used, false, sizeof(used));
            generatePermutations(digits_to_permute, permute_length, 0, 0, used);
        }
        return;
    }

    // Option 1: Don't include digit_val in the set of digits for the balanced number
    chosen_digits_counts[digit_val] = 0;
    chooseDigits(digit_val + 1, current_length, chosen_digits_counts);

    // Option 2: Include digit_val in the set of digits for the balanced number
    // If digit_val is included, its count must be digit_val itself.
    // This adds digit_val to the total length of the number.
    chosen_digits_counts[digit_val] = digit_val;
    chooseDigits(digit_val + 1, current_length + digit_val, chosen_digits_counts);
}

static void precompute_all_balanced_numbers() {
    if (precomputed_flag) return; // Ensure precomputation happens only once

    int chosen_digits_counts[10];
    memset(chosen_digits_counts, 0, sizeof(chosen_digits_counts));

    balancedCount = 0; // Reset count for precomputation
    chooseDigits(1, 0, chosen_digits_counts);

    // After generating all permutations, sort the list of numbers
    qsort(balancedNumbers, balancedCount, sizeof(int), compareInts);

    // Remove duplicate numbers (e.g., 122, 212, 221 are all distinct numbers but might be generated)
    if (balancedCount > 0) {
        int unique_count = 1;
        for (int i = 1; i < balancedCount; ++i) {
            if (balancedNumbers[i] != balancedNumbers[i-1]) {
                balancedNumbers[unique_count++] = balancedNumbers[i];
            }
        }
        balancedCount = unique_count;
    }

    precomputed_flag = true;
}

int nextGreaterNumericallyBalancedNumber(int n) {
    precompute_all_balanced_numbers();

    // Find the first balanced number strictly greater than n
    for (int i = 0; i < balancedCount; ++i) {
        if (balancedNumbers[i] > n) {
            return balancedNumbers[i];
        }
    }
    // According to problem constraints (n <= 10^5) and the fact that the largest
    // balanced number fitting in an int is 1999999999, a suitable number will always be found.
    return -1; // Should not be reached
}