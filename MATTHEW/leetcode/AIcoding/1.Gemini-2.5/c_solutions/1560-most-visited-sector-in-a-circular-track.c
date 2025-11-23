#include <stdlib.h>

int* mostVisited(int n, int* rounds, int roundsSize, int* returnSize) {
    int start = rounds[0];
    int end = rounds[roundsSize - 1];

    int* result;
    int count;

    if (start <= end) {
        count = end - start + 1;
        result = (int*)malloc(count * sizeof(int));
        for (int i = 0; i < count; ++i) {
            result[i] = start + i;
        }
    } else { // start > end
        // Sectors from 1 to end
        // Sectors from start to n
        count = end + (n - start + 1);
        result = (int*)malloc(count * sizeof(int));
        int current_idx = 0;
        for (int i = 1; i <= end; ++i) {
            result[current_idx++] = i;
        }
        for (int i = start; i <= n; ++i) {
            result[current_idx++] = i;
        }
    }

    *returnSize = count;
    return result;
}