#include <stdio.h>
#include <stdlib.h>

int numberOfSubarrays(char* s, int* pattern, int patternSize) {
    int n = strlen(s);
    int count = 0;
    int len = 0;

    for (int i = 0; i < n; i++) {
        if (i > 0 && (s[i] - '0') == (s[i-1] - '0')) {
            len = 0;
        } else {
            len++;
        }

        if (len >= patternSize) {
            int match = 1;
            for (int j = 0; j < patternSize; j++) {
                if ((s[i - j] - '0') != pattern[j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }
    }

    return count;
}