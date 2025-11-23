#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shortestUncommonSubsequence(char **source, int sourceSize, char **target, int targetSize) {
    int minLen = 11;
    for (int len = 1; len <= 10; len++) {
        for (int i = 0; i < sourceSize; i++) {
            int sourceLen = strlen(source[i]);
            for (int j = 0; j <= sourceLen - len; j++) {
                char sub[11];
                strncpy(sub, source[i] + j, len);
                sub[len] = '\0';

                bool found = false;
                for (int k = 0; k < targetSize; k++) {
                    int targetLen = strlen(target[k]);
                    for (int l = 0; l <= targetLen - len; l++) {
                        if (strncmp(target[k] + l, sub, len) == 0) {
                            found = true;
                            break;
                        }
                    }
                    if (found) break;
                }

                if (!found) {
                    return len;
                }
            }
        }
    }
    return -1;
}