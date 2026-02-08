#include <string.h>
#include <stdlib.h>

char* maximumBinaryString(char* binary) {
    int n = strlen(binary);
    int count_zeros = 0;
    int first_zero_idx = -1;

    // Count the total number of zeros and find the index of the first zero
    for (int i = 0; i < n; i++) {
        if (binary[i] == '0') {
            count_zeros++;
            if (first_zero_idx == -1) {
                first_zero_idx = i;
            }
        }
    }

    // Case 1: No zeros in the string.
    // The string is already all '1's, which is the lexicographically largest possible.
    if (count_zeros == 0) {
        char* result = (char*)malloc(sizeof(char) * (n + 1));
        strcpy(result, binary);
        return result;
    }

    // Case 2: Exactly one zero in the string.
    // The '00 -> 10' operation is not applicable as there are no adjacent '0's.
    // The '10 -> 01' operation allows a '1' to move past a '0' to its right.
    // This effectively moves the '0' to the left.
    // Therefore, the single '0' can be moved to the leftmost position.
    // The lexicographically largest string with one '0' will be '0' followed by N-1 '1's.
    if (count_zeros == 1) {
        char* result = (char*)malloc(sizeof(char) * (n + 1));
        for (int i = 0; i < n; i++) {
            result[i] = '1';
        }
        result[0] = '0'; // Place the single '0' at the beginning
        result[n] = '\0';
        return result;
    }

    // Case 3: More than one zero in the string (count_zeros > 1).
    // The '00 -> 10' operation can be used to convert (count_zeros - 1) of the zeros into ones.
    // This leaves exactly one '0' in the string.
    // The total number of '1's in the final string will be (N - count_zeros) + (count_zeros - 1) = N - 1.
    // The position of this single remaining '0' will be at 'first_zero_idx + (count_zeros - 1)'.
    // All characters before this calculated position will be '1's.
    // All characters after this calculated position will also be '1's.
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    for (int i = 0; i < n; i++) {
        result[i] = '1';
    }
    result[first_zero_idx + (count_zeros - 1)] = '0'; // Place the single '0' at its determined position
    result[n] = '\0';
    return result;
}