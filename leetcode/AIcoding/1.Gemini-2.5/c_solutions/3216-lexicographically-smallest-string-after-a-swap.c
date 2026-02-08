#include <string.h>
#include <stdlib.h>

char* smallestString(char* s) {
    int n = strlen(s);
    if (n <= 1) {
        return s;
    }

    for (int i = 0; i < n - 1; i++) {
        // Step 1: Find the smallest character value in the substring s[i+1...n-1]
        // Initialize min_val with a character larger than any possible character in s
        // or effectively, with s[i] itself to compare against subsequent characters.
        char min_val = s[i]; 

        // This loop finds the true minimum character value in the range s[i+1...n-1]
        // compared to s[i]. If s[i] is already the smallest, min_val won't change to something smaller.
        for (int j = i + 1; j < n; j++) {
            if (s[j] < min_val) {
                min_val = s[j];
            }
        }

        // If s[i] is already the smallest character compared to min_val
        // (i.e., min_val is equal to s[i] or greater than s[i]), no swap for s[i] can make it smaller.
        if (min_val >= s[i]) {
            continue; // Move to the next position i
        }

        // Step 2: If a character smaller than s[i] was found (min_val < s[i]),
        // find the *rightmost* index of this `min_val` character in s[i+1...n-1].
        // Swapping with the rightmost occurrence ensures the lexicographically smallest string.
        int swap_idx = -1;
        for (int j = n - 1; j > i; j--) { // Iterate from right to left
            if (s[j] == min_val) {
                swap_idx = j;
                break; // Found the rightmost occurrence
            }
        }

        // Step 3: Perform the swap
        char temp = s[i];
        s[i] = s[swap_idx];
        s[swap_idx] = temp;

        // Since we can perform at most one swap, we are done after the first effective swap.
        return s;
    }

    // If the loop completes, it means no swap was needed or possible to make the string lexicographically smaller.
    return s;
}