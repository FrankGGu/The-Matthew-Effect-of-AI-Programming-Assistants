#include <string.h>

char* lastSubstring(char* s) {
    int n = strlen(s);
    int i = 0; // Pointer for the current best candidate substring start
    int j = 1; // Pointer for the substring being compared
    int k = 0; // Length of common prefix between s[i...] and s[j...]

    while (j + k < n) {
        if (s[i + k] == s[j + k]) {
            k++;
        } else if (s[i + k] < s[j + k]) {
            // Current substring s[j...] is lexicographically larger
            // The new candidate starts at j.
            // All substrings starting from s[i] up to s[j+k-1] are smaller or equal to s[i...],
            // and thus smaller than s[j...].
            i = j;
            j = i + 1; // Start comparing from the next character after new i
            k = 0;
        } else { // s[i + k] > s[j + k]
            // Current substring s[i...] is lexicographically larger
            // The substring s[j...] is smaller.
            // We can skip all substrings starting from s[j] up to s[j+k]
            // because they will all be smaller than s[i...].
            j = j + k + 1;
            k = 0;
        }
    }

    return s + i;
}