#include <stdbool.h>
#include <string.h>
#include <stdlib.h> // Required for atoi if needed, but not directly for this solution

bool digitCount(char * num){
    int n = strlen(num);
    int counts[10] = {0}; // Frequency array for digits 0-9

    // First pass: Populate the frequency array
    for (int i = 0; i < n; i++) {
        counts[num[i] - '0']++;
    }

    // Second pass: Check the condition
    for (int i = 0; i < n; i++) {
        // The digit at index i is num[i] - '0'
        // The number of times digit i appears in num is counts[i]
        if ((num[i] - '0') != counts[i]) {
            return false;
        }
    }

    return true;
}