#include <string.h>
#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minFlipsMonoIncr(char * s){
    int n = strlen(s);

    // ones_in_prefix: counts '1's in the current prefix (s[0...k])
    // These '1's need to be flipped to '0's if the prefix is to be all '0's.
    int ones_in_prefix = 0;

    // zeros_in_suffix: counts '0's in the current suffix (s[k+1...n-1])
    // These '0's need to be flipped to '1's if the suffix is to be all '1's.
    // Initially, this is the total count of '0's in the entire string.
    int zeros_in_suffix = 0;

    // Calculate the total number of '0's in the string.
    // This value represents the flips needed if the entire string were to become '1's (i.e., split point i=0).
    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            zeros_in_suffix++;
        }
    }

    // Initialize min_flips with the case where the entire string is '1's.
    // In this scenario, all initial '0's must be flipped to '1's.
    int min_flips = zeros_in_suffix;

    // Iterate through all possible split points.
    // The loop variable 'k' iterates from 0 to n-1.
    // After processing s[k], we consider the split point to be after s[k].
    // This means s[0...k] forms the '0's part and s[k+1...n-1] forms the '1's part.
    for (int k = 0; k < n; k++) {
        if (s[k] == '0') {
            // If s[k] is '0', it's now part of the prefix (s[0...k]).
            // It doesn't need to be flipped if the prefix is all '0's.
            // Since it's no longer in the suffix (s[k+1...n-1]), we decrement zeros_in_suffix.
            zeros_in_suffix--;
        } else { // s[k] == '1'
            // If s[k] is '1', it's now part of the prefix (s[0...k]).
            // It needs to be flipped to '0' if the prefix is all '0's.
            // So, we increment ones_in_prefix.
            ones_in_prefix++;
        }

        // The current number of flips for the split point after s[k] is:
        // (number of '1's in s[0...k] that need to be flipped to '0')
        // + (number of '0's in s[k+1...n-1] that need to be flipped to '1')
        min_flips = min(min_flips, ones_in_prefix + zeros_in_suffix);
    }

    // The loop covers split points from i=1 to i=n (all '0's).
    // The initial min_flips covers split point i=0 (all '1's).
    return min_flips;
}