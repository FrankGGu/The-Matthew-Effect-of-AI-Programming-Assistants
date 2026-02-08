#include <stdio.h>
#include <stdlib.h>

int countHouses(int n, int x, int y) {
    int* dist = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = abs(i - x) + 1;
    }
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] == y) {
            count++;
        }
    }
    free(dist);
    return count;
}