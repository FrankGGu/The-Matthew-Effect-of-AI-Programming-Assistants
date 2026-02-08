#include <string.h>
#include <stdlib.h>

char* shortestPalindrome(char* s) {
    int n = strlen(s);
    if (n == 0) return strdup("");

    // Create reversed string
    char* rev = (char*)malloc(n + 1);
    for (int i = 0; i < n; i++) {
        rev[i] = s[n - 1 - i];
    }
    rev[n] = '\0';

    // Create pattern s + "#" + rev
    char* pattern = (char*)malloc(2 * n + 2);
    strcpy(pattern, s);
    pattern[n] = '#';
    strcpy(pattern + n + 1, rev);
    int len = 2 * n + 1;

    // Build KMP table
    int* lps = (int*)calloc(len, sizeof(int));
    int i = 1, j = 0;
    while (i < len) {
        if (pattern[i] == pattern[j]) {
            lps[i] = j + 1;
            i++;
            j++;
        } else {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    // Find the longest prefix of s that is a suffix of rev
    int maxMatch = lps[len - 1];

    // Construct result
    int resultLen = n + (n - maxMatch);
    char* result = (char*)malloc(resultLen + 1);
    strcpy(result, rev);
    strcpy(result + (n - maxMatch), s);
    result[resultLen] = '\0';

    free(rev);
    free(pattern);
    free(lps);

    return result;
}