#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasAllCodes(char *s, int k) {
    int totalCodes = 1 << k;
    int len = strlen(s);
    if (len < totalCodes + k - 1) return false;

    int *seen = (int *)calloc(totalCodes, sizeof(int));
    int hash = 0;

    for (int i = 0; i < k; i++) {
        hash = (hash << 1) | (s[i] - '0');
    }
    seen[hash] = 1;

    for (int i = k; i < len; i++) {
        hash = ((hash << 1) & (totalCodes - 1)) | (s[i] - '0');
        seen[hash] = 1;
    }

    for (int i = 0; i < totalCodes; i++) {
        if (seen[i] == 0) {
            free(seen);
            return false;
        }
    }

    free(seen);
    return true;
}