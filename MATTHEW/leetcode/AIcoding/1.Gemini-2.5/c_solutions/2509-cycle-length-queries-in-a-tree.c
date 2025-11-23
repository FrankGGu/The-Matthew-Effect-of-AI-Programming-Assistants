#include <stdlib.h>

int get_depth(int node) {
    int depth = 0;
    while (node > 1) {
        node /= 2;
        depth++;
    }
    return depth;
}

int* cycleLengthQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    int* results = (int*)malloc(sizeof(int) * queriesSize);

    for (int i = 0; i < queriesSize; i++) {
        int u = queries[i][0];
        int v = queries[i][1];

        int depth_u = get_depth(u);
        int depth_v = get_depth(v);

        int steps_u = 0;
        int steps_v = 0;

        while (depth_u > depth_v) {
            u /= 2;
            depth_u--;
            steps_u++;
        }
        while (depth_v > depth_u) {
            v /= 2;
            depth_v--;
            steps_v++;
        }

        while (u != v) {
            u /= 2;
            v /= 2;
            steps_u++;
            steps_v++;
        }

        results[i] = steps_u + steps_v + 1;
    }

    return results;
}