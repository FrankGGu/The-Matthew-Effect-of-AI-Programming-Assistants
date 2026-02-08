#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxTransferRequests(int** requests, int requestsSize, int* requestsColSize, int n) {
    int m = requestsSize;
    int max = 0;
    for (int mask = 1; mask < (1 << m); mask++) {
        int count = 0;
        int* diff = (int*)calloc(n, sizeof(int));
        for (int i = 0; i < m; i++) {
            if (mask & (1 << i)) {
                count++;
                diff[requests[i][0]]++;
                diff[requests[i][1]]--;
            }
        }
        int valid = 1;
        for (int i = 0; i < n; i++) {
            if (diff[i] != 0) {
                valid = 0;
                break;
            }
        }
        free(diff);
        if (valid) {
            max = (count > max) ? count : max;
        }
    }
    return max;
}