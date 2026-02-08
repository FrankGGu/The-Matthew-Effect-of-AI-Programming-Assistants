#include <stdio.h>
#include <stdlib.h>

int* longestAlternatingGroups(int* groups, int groupsSize, int* returnSize) {
    int n = groupsSize;
    int* result = (int*)malloc(n * sizeof(int));
    int len = 0;
    int i = 0;
    while (i < n) {
        int j = i;
        while (j + 1 < n && groups[j] != groups[j + 1]) {
            j++;
        }
        for (int k = i; k <= j; k++) {
            result[len++] = k;
        }
        i = j + 1;
    }
    *returnSize = len;
    return result;
}