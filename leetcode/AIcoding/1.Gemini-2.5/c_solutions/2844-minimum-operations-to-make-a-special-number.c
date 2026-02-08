#include <string.h>
#include <limits.h> // For INT_MAX
#include <stdlib.h> // For min function, though a macro is often used

int min(int a, int b) {
    return a < b ? a : b;
}

int minimumOperations(char* num) {
    int n = strlen(num);
    int min_ops = INT_MAX;

    // Define the target suffixes as pairs of characters
    // Suffixes: "00", "25", "50", "75"
    char target_d1[] = {'0', '2', '5', '7'};
    char target_d2[] = {'0', '5', '0', '5'};

    // Iterate through each of the four target suffixes
    for (int k = 0; k < 4; k++) {
        char d1 = target_d1[k];
        char d2 = target_d2[k];

        int deletions = 0;
        int found_d2 = 0; // Flag for finding the second digit (rightmost)
        int found_d1 = 0; // Flag for finding the first digit (to the left of d2)

        // Iterate from right to left to find d2, then d1
        for (int i = n - 1; i >= 0; i--) {
            if (!found_d2 && num[i] == d2) {
                found_d2 = 1;
            } else if (found_d2 && num[i] == d1) {
                found_d1 = 1;
                break; // Found both digits in correct order
            } else {
                deletions++; // This digit must be deleted
            }
        }

        // If both digits were found, update min_ops
        if (found_d1 && found_d2) {
            min_ops = min(min_ops, deletions);
        }
    }

    // Special case handling based on LeetCode example "10" -> "0" (1 operation).
    // This implies that "0" itself is considered a special number.
    // If the number contains at least one '0', we can delete all other digits to form "0".
    // This takes (n - 1) operations.
    int has_zero = 0;
    for (int i = 0; i < n; i++) {
        if (num[i] == '0') {
            has_zero = 1;
            break;
        }
    }

    if (has_zero) {
        min_ops = min(min_ops, n - 1);
    }

    return min_ops;
}