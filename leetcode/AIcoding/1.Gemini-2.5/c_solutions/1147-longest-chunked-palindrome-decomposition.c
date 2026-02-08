#include <string.h>
#include <stdlib.h>

int longestDecomposition(char *text) {
    int n = strlen(text);
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }

    for (int i = 1; i <= n / 2; i++) {
        // Compare prefix of length i with suffix of length i
        // text[0...i-1] vs text[n-i...n-1]
        int match = 1;
        for (int j = 0; j < i; j++) {
            if (text[j] != text[n - i + j]) {
                match = 0;
                break;
            }
        }

        if (match) {
            // If they match, we found two chunks.
            // Recursively call for the middle part.
            // The middle part is text[i...n-i-1]
            // Its length is (n-i) - i = n - 2*i
            char *subtext = (char *)malloc(sizeof(char) * (n - 2 * i + 1));
            strncpy(subtext, text + i, n - 2 * i);
            subtext[n - 2 * i] = '\0';
            int result = 2 + longestDecomposition(subtext);
            free(subtext);
            return result;
        }
    }

    // If no prefix matches any suffix, the whole string is one chunk.
    return 1;
}