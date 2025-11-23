#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* movesToStamp(char * stamp, char * target, int* returnSize) {
    int m = strlen(stamp);
    int n = strlen(target);
    int* res = (int*)malloc(sizeof(int) * n);
    int resIndex = 0;
    int* done = (int*)calloc(n, sizeof(int));
    int stampedCount = 0;

    while (stampedCount < n) {
        int stampPerformed = 0;
        for (int i = 0; i <= n - m; i++) {
            if (done[i]) continue;

            int canStamp = 1;
            int replaceCount = 0;
            for (int j = 0; j < m; j++) {
                if (target[i + j] == stamp[j]) {
                    // Match
                } else if (target[i + j] == '?') {
                    // Already stamped
                } else {
                    canStamp = 0;
                    break;
                }
            }

            if (canStamp) {
                for (int j = 0; j < m; j++) {
                    if (target[i + j] != '?') {
                        target[i + j] = '?';
                        stampedCount++;
                        replaceCount++;
                    }
                }

                if (replaceCount > 0) {
                    res[resIndex++] = i;
                    done[i] = 1;
                    stampPerformed = 1;
                }
            }
        }

        if (!stampPerformed) {
            free(res);
            free(done);
            *returnSize = 0;
            return NULL;
        }
    }

    int* finalRes = (int*)malloc(sizeof(int) * resIndex);
    for (int i = 0; i < resIndex; i++) {
        finalRes[i] = res[resIndex - 1 - i];
    }

    free(res);
    free(done);
    *returnSize = resIndex;
    return finalRes;
}