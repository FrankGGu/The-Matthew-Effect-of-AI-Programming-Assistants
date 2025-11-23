#include <stdlib.h>

int* processQueries(int* queries, int queriesSize, int m, int* returnSize) {
    int* results = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    int* P = (int*)malloc(sizeof(int) * m);
    for (int i = 0; i < m; i++) {
        P[i] = i + 1;
    }

    for (int i = 0; i < queriesSize; i++) {
        int query_val = queries[i];
        int found_index = -1;

        for (int j = 0; j < m; j++) {
            if (P[j] == query_val) {
                found_index = j;
                break;
            }
        }

        results[i] = found_index;

        int val_to_move = P[found_index];

        for (int k = found_index; k > 0; k--) {
            P[k] = P[k - 1];
        }

        P[0] = val_to_move;
    }

    free(P);

    return results;
}