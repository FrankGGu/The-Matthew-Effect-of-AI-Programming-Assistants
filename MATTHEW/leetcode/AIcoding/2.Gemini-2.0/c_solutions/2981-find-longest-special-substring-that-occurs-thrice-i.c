#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSpecialSubstring(char * s) {
    int n = strlen(s);
    int maxLen = -1;

    for (int len = 1; len <= n / 3; len++) {
        for (char c = 'a'; c <= 'z'; c++) {
            char target[len + 1];
            for (int i = 0; i < len; i++) {
                target[i] = c;
            }
            target[len] = '\0';

            int count = 0;
            for (int i = 0; i <= n - len; i++) {
                bool match = true;
                for (int j = 0; j < len; j++) {
                    if (s[i + j] != c) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    count++;
                }
            }

            if (count >= 3) {
                maxLen = len;
            }
        }
    }

    return maxLen;
}