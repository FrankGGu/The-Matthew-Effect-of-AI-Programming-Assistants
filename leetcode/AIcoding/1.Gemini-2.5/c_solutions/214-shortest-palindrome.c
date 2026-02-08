#include <stdlib.h>
#include <string.h>

char* shortestPalindrome(char* s) {
    int n = strlen(s);

    if (n == 0) {
        return strdup("");
    }

    // 1. Create the reversed string s_rev
    char* s_rev = (char*)malloc(sizeof(char) * (n + 1));
    for (int i = 0; i < n; i++) {
        s_rev[i] = s[n - 1 - i];
    }
    s_rev[n] = '\0';

    // 2. Construct the KMP pattern string: s + "#" + s_rev
    // Total length = n (s) + 1 (#) + n (s_rev) = 2n + 1
    int temp_len = 2 * n + 1;
    char* temp = (char*)malloc(sizeof(char) * (temp_len + 1));
    strcpy(temp, s);
    temp[n] = '#';
    strcpy(temp + n + 1, s_rev);
    // temp is now null-terminated by the strcpy of s_rev

    // 3. Compute the LPS array for the temp string
    // pi[i] stores the length of the longest proper prefix of temp[0...i]
    // that is also a suffix of temp[0...i].
    int* pi = (int*)malloc(sizeof(int) * temp_len);
    pi[0] = 0;
    for (int i = 1; i < temp_len; i++) {
        int j = pi[i - 1]; // Length of the previous longest prefix suffix

        // While current character doesn't match and j is not 0,
        // move to the next smaller prefix suffix
        while (j > 0 && temp[i] != temp[j]) {
            j = pi[j - 1];
        }

        // If characters match, extend the prefix suffix
        if (temp[i] == temp[j]) {
            j++;
        }
        pi[i] = j;
    }

    // The last element of the pi array (pi[temp_len - 1]) gives the length
    // of the longest prefix of 's' that is also a suffix of 's_rev'.
    // This is exactly the length of the longest palindromic prefix of 's'.
    int longest_pal_prefix_len = pi[temp_len - 1];

    // 4. Construct the result string
    // The characters to prepend are the suffix of 's' that is NOT part of
    // the longest palindromic prefix, reversed.
    // This suffix is s[longest_pal_prefix_len ... n-1].
    // Its length is n - longest_pal_prefix_len.
    // The result string will have length:
    // (n - longest_pal_prefix_len) (for the prepended part) + n (for original s) + 1 (for null terminator)
    char* result = (char*)malloc(sizeof(char) * (n - longest_pal_prefix_len + n + 1));
    int res_idx = 0;

    // Prepend the reversed suffix
    // Iterate from the end of 's' down to the character just after the longest palindromic prefix
    for (int i = n - 1; i >= longest_pal_prefix_len; i--) {
        result[res_idx++] = s[i];
    }

    // Append the original string s
    strcpy(result + res_idx, s);

    // Free allocated memory
    free(s_rev);
    free(temp);
    free(pi);

    return result;
}