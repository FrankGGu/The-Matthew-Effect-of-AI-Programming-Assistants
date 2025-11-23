#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INF 1000000

int* minimumReverseOperations(int n, int p, int* banned, int bannedSize, int k, int* queries, int queriesSize, int* returnSize) {
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        ans[i] = INF;
    }

    for (int i = 0; i < queriesSize; i++) {
        int query = queries[i];
        int* dist = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[j] = INF;
        }
        dist[p] = 0;

        int* q = (int*)malloc(n * sizeof(int));
        int head = 0, tail = 0;
        q[tail++] = p;

        int* isBanned = (int*)calloc(n, sizeof(int));
        for (int j = 0; j < bannedSize; j++) {
            isBanned[banned[j]] = 1;
        }
        isBanned[p] = 1;

        while (head < tail) {
            int u = q[head++];
            for (int j = 0; j < n; j++) {
                int left = u - (k - 1 - abs(u - j));
                int right = u + (k - 1 - abs(u - j));
                if (left >= 0 && right < n && left <= j && j <= right && k % 2 == (abs(u - j) % 2)) {
                    if (dist[j] == INF && isBanned[j] == 0) {
                        dist[j] = dist[u] + 1;
                        q[tail++] = j;
                        isBanned[j] = 1;
                    }
                }
            }
        }

        if (dist[query] == INF) {
            ans[i] = -1;
        } else {
            ans[i] = dist[query];
        }

        free(dist);
        free(q);
        free(isBanned);
    }

    return ans;
}