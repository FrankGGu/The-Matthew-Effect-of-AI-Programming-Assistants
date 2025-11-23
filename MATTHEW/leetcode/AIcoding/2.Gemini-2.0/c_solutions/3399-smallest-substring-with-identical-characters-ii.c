#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int smallestSubstring(char *s) {
    int n = strlen(s);
    int minLen = INT_MAX;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int count[26] = {0};
            for (int k = i; k <= j; k++) {
                count[s[k] - 'a']++;
            }

            int maxCount = 0;
            for (int k = 0; k < 26; k++) {
                if (count[k] > maxCount) {
                    maxCount = count[k];
                }
            }

            int numMax = 0;
            for (int k = 0; k < 26; k++) {
                if (count[k] == maxCount && maxCount > 0) {
                    numMax++;
                }
            }

            if (numMax > 1) {
                minLen = (minLen < (j - i + 1)) ? minLen : (j - i + 1);
            }
        }
    }

    return (minLen == INT_MAX) ? -1 : minLen;
}