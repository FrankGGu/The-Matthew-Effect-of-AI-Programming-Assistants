#include <string.h>

int partitionString(char * s, int k){
    long long current_val = 0;
    int partitions = 0;
    int i = 0;

    while (s[i] != '\0') {
        int digit = s[i] - '0';

        // Check if adding this digit would exceed k
        // This check prevents overflow if current_val * 10 + digit were computed directly
        // k is int, so k / 10 and k % 10 are int.
        // current_val is long long, so comparisons implicitly promote k/10 to long long.
        if (current_val > k / 10 || (current_val == k / 10 && digit > k % 10)) {
            // Cannot add this digit to the current substring.
            // Finalize the current substring.
            partitions++;
            // Start a new substring with the current digit.
            current_val = digit;
        } else {
            // Can add this digit to the current substring.
            current_val = current_val * 10 + digit;
        }
        i++;
    }

    // After the loop, there's always one last substring that needs to be counted.
    partitions++; 
    return partitions;
}