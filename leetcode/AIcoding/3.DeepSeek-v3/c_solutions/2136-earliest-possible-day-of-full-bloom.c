#include <stdlib.h>

int cmp(const void* a, const void* b) {
    int* pa = *(int**)a;
    int* pb = *(int**)b;
    return pb[1] - pa[1];
}

int earliestFullBloom(int* plantTime, int plantTimeSize, int* growTime, int growTimeSize) {
    int n = plantTimeSize;
    int** pairs = malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        pairs[i] = malloc(2 * sizeof(int));
        pairs[i][0] = plantTime[i];
        pairs[i][1] = growTime[i];
    }

    qsort(pairs, n, sizeof(int*), cmp);

    int total = 0;
    int current = 0;
    for (int i = 0; i < n; i++) {
        current += pairs[i][0];
        total = (current + pairs[i][1] > total) ? current + pairs[i][1] : total;
    }

    for (int i = 0; i < n; i++) {
        free(pairs[i]);
    }
    free(pairs);

    return total;
}