#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* movesToStamp(char* stamp, char* target, int* returnSize) {
    int m = strlen(stamp);
    int n = strlen(target);
    int* res = (int*)malloc(n * sizeof(int));
    int resIdx = 0;
    int changed;
    int total = 0;
    int* visited = (int*)calloc(n, sizeof(int));

    while (1) {
        changed = 0;
        for (int i = 0; i <= n - m; i++) {
            if (visited[i]) continue;
            int j;
            int match = 1;
            for (j = 0; j < m; j++) {
                if (target[i + j] != stamp[j]) {
                    match = 0;
                    break;
                }
            }
            if (match) {
                res[resIdx++] = i;
                visited[i] = 1;
                changed = 1;
                total += m;
                for (j = 0; j < m; j++) {
                    target[i + j] = '0';
                }
                break;
            }
        }
        if (!changed) break;
    }

    if (total != n) {
        *returnSize = 0;
        free(res);
        free(visited);
        return NULL;
    }

    *returnSize = resIdx;
    int* result = (int*)malloc(resIdx * sizeof(int));
    for (int i = 0; i < resIdx; i++) {
        result[i] = res[resIdx - 1 - i];
    }
    free(res);
    free(visited);
    return result;
}