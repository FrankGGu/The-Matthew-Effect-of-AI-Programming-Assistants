#include <stdio.h>
#include <stdlib.h>

int findLatestGroup(int* arr, int n, int m) {
    int* pos = (int*)malloc((n + 1) * sizeof(int));
    int* len = (int*)malloc((n + 2) * sizeof(int));
    int res = -1;
    for (int i = 0; i < n; i++) {
        int x = arr[i];
        int left = len[x - 1];
        int right = len[x + 1];
        len[x] = left + right + 1;
        len[x - left] = left + right + 1;
        len[x + right] = left + right + 1;
        if (left + right + 1 == m) {
            res = i + 1;
        }
    }
    free(pos);
    free(len);
    return res;
}