#include <stdio.h>
#include <stdlib.h>

long long countBlackBlocks(char* blocks, int n) {
    int* count = (int*)calloc(n, sizeof(int));
    long long result = 0;
    for (int i = 0; i < n; i++) {
        if (blocks[i] == 'B') {
            count[i]++;
            if (i > 0) count[i - 1]++;
            if (i < n - 1) count[i + 1]++;
        }
    }
    for (int i = 0; i < n; i++) {
        if (count[i] > 0) result += count[i];
    }
    free(count);
    return result;
}