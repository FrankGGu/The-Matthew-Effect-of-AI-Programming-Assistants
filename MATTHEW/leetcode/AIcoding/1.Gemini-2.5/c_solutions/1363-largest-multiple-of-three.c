#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static bool remove_one_digit(int* counts, int remainder_target) {
    // Iterate through digits that have the target remainder, from smallest to largest
    // e.g., if remainder_target is 1, check 1, then 4, then 7.
    // e.g., if remainder_target is 2, check 2, then 5, then 8.
    for (int d = remainder_target; d <= 9; d += 3) {
        if (counts[d] > 0) {
            counts[d]--;
            return true;
        }
    }
    return false;
}

static bool remove_two_digits(int* counts, int remainder_target) {
    int digits_to_consider[3];
    int num_digits_to_consider = 0;

    // Populate digits_to_consider with digits that have the target remainder
    for (int d = remainder_target; d <= 9; d += 3) {
        digits_to_consider[num_digits_to_consider++] = d;
    }

    // Try to remove two digits. Prioritize removing the smallest possible pair.
    // Iterate through possible pairs (d1, d2) where d1 <= d2
    for (int i = 0; i < num_digits_to_consider; i++) {
        int d1 = digits_to_consider[i];
        if (counts[d1] == 0) continue;

        counts[d1]--; // Temporarily remove d1

        for (int j = i; j < num_digits_to_consider; j++) { // d2 must be >= d1
            int d2 = digits_to_consider[j];
            if (counts[d2] > 0) {
                counts[d2]--; // Remove d2
                return true; // Successfully removed two digits
            }
        }
        counts[d1]++; // If no d2 found for this d1, put d1 back
    }
    return false;
}

char* largestMultipleOfThree(int* digits, int digitsSize) {
    int counts[10] = {0}; // counts[d] stores the frequency of digit d
    int sum = 0;

    // Calculate digit frequencies and total sum
    for (int i = 0; i < digitsSize; i++) {
        counts[digits[i]]++;
        sum += digits[i];
    }

    int sum_mod = sum % 3;

    // If the sum of digits is not a multiple of 3, we need to remove some digits.
    if (sum_mod != 0) {
        bool removed_successfully = false;
        if (sum_mod == 1) {
            // If sum % 3 == 1, we need to remove digits whose sum % 3 == 1.
            // Option 1: Remove one digit with remainder 1 (1, 4, 7). Prioritize smallest.
            if (remove_one_digit(counts, 1)) {
                removed_successfully = true;
            } else {
                // Option 2: If Option 1 is not possible, remove two digits with remainder 2 (2, 5, 8).
                // Their sum (e.g., 2+2=4, 2+5=7) will have remainder 1. Prioritize two smallest.
                if (remove_two_digits(counts, 2)) {
                    removed_successfully = true;
                }
            }
        } else { // sum_mod == 2
            // If sum % 3 == 2, we need to remove digits whose sum % 3 == 2.
            // Option 1: Remove one digit with remainder 2 (2, 5, 8). Prioritize smallest.
            if (remove_one_digit(counts, 2)) {
                removed_successfully = true;
            } else {
                // Option 2: If Option 1 is not possible, remove two digits with remainder 1 (1, 4, 7).
                // Their sum (e.g., 1+1=2, 1+4=5) will have remainder 2. Prioritize two smallest.
                if (remove_two_digits(counts, 1)) {
                    removed_successfully = true;
                }
            }
        }
    }

    // Construct the result string from remaining digits
    int total_digits_remaining = 0;
    for (int i = 0; i < 10; i++) {
        total_digits_remaining += counts[i];
    }

    // If no digits remain after removal, return an empty string
    if (total_digits_remaining == 0) {
        char* res = (char*)malloc(sizeof(char) * 1);
        res[0] = '\0';
        return res;
    }

    // Allocate memory for the result string (+1 for null terminator)
    char* result = (char*)malloc(sizeof(char) * (total_digits_remaining + 1));
    int k = 0;

    // Append digits to the result in descending order to form the largest number
    for (int d = 9; d >= 0; d--) {
        for (int i = 0; i < counts[d]; i++) {
            result[k++] = d + '0';
        }
    }
    result[k] = '\0'; // Null-terminate the string

    // Handle the special case where the result consists of only zeros (e.g., "000" should be "0")
    if (result[0] == '0' && total_digits_remaining > 1) {
        // This condition implies all remaining digits are '0'.
        // For example, if input was [2,2,0], sum=4, sum_mod=1. Remove two '2's. Remaining: [0]. Result "0".
        // If input was [0,0,0], sum=0, sum_mod=0. No removal. Remaining: [0,0,0]. Result "000".
        // In this specific case, "000" should be "0".
        result[0] = '0';
        result[1] = '\0';
    }

    return result;
}