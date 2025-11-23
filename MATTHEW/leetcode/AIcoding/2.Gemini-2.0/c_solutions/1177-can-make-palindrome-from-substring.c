#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* canMakePaliQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = strlen(s);
    int pre[n + 1];
    pre[0] = 0;
    for (int i = 0; i < n; i++) {
        pre[i + 1] = pre[i] ^ (1 << (s[i] - 'a'));
    }

    bool* ans = (bool*)malloc(sizeof(bool) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0];
        int r = queries[i][1];
        int k = queries[i][2];

        int mask = pre[r + 1] ^ pre[l];
        int bits = 0;
        for (int j = 0; j < 26; j++) {
            if ((mask >> j) & 1) {
                bits++;
            }
        }
        ans[i] = (bits / 2 <= k);
    }

    return ans;
}