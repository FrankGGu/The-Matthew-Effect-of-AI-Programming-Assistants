#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int miceAndCheese(int* ratings, int ratingsSize, int k) {
    qsort(ratings, ratingsSize, sizeof(int), compare);
    int total = 0;
    for (int i = 0; i < k; i++) {
        total += ratings[i];
    }
    return total;
}