#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* substringXorQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * 2 * sizeof(int));
    *returnSize = queriesSize * 2;
    for (int i = 0; i < queriesSize; i++) {
        result[i * 2] = -1;
        result[i * 2 + 1] = -1;
        int first = queries[i][0];
        int second = queries[i][1];
        int target = first ^ second;
        char targetStr[33];
        sprintf(targetStr, "%d", target);
        char* p = strstr(s, targetStr);
        if (p != NULL) {
            int index = p - s;
            result[i * 2] = index;
            result[i * 2 + 1] = index + strlen(targetStr) - 1;
        } else {
            int n = strlen(s);
            for (int j = 0; j < n; j++) {
                for (int k = j; k < n; k++) {
                    char sub[33];
                    memset(sub, 0, sizeof(sub));
                    for (int l = j; l <= k; l++) {
                        sub[l - j] = s[l];
                    }
                    int num = 0;
                    if (strlen(sub) > 0) {
                        num = atoi(sub);
                    }
                    if (num == target) {
                        result[i * 2] = j;
                        result[i * 2 + 1] = k;
                        goto next_query;
                    }
                }
            }
        }
        next_query:;
    }
    return result;
}