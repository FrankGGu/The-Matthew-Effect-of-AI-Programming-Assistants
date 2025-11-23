#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    int* env1 = *(int**)a;
    int* env2 = *(int**)b;

    if (env1[0] != env2[0]) {
        return env1[0] - env2[0];
    } else {
        return env2[1] - env1[1];
    }
}

int maxEnvelopes(int** envelopes, int envelopesSize, int* envelopesColSize) {
    if (envelopesSize == 0) return 0;

    qsort(envelopes, envelopesSize, sizeof(int*), compare);

    int dp[envelopesSize];
    int len = 0;

    for (int i = 0; i < envelopesSize; i++) {
        int envelopeHeight = envelopes[i][1];
        int left = 0, right = len;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (dp[mid] < envelopeHeight) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        dp[left] = envelopeHeight;
        if (left == len) {
            len++;
        }
    }

    return len;
}