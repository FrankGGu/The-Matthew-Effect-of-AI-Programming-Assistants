#include <stdio.h>
#include <stdlib.h>

int candy(int* ratings, int ratingsSize) {
    if (ratingsSize == 0) return 0;
    int* candy = (int*)malloc(ratingsSize * sizeof(int));
    for (int i = 0; i < ratingsSize; i++) {
        candy[i] = 1;
    }
    for (int i = 1; i < ratingsSize; i++) {
        if (ratings[i] > ratings[i - 1]) {
            candy[i] = candy[i - 1] + 1;
        }
    }
    for (int i = ratingsSize - 2; i >= 0; i--) {
        if (ratings[i] > ratings[i + 1]) {
            candy[i] = (candy[i + 1] + 1) > candy[i] ? (candy[i + 1] + 1) : candy[i];
        }
    }
    int total = 0;
    for (int i = 0; i < ratingsSize; i++) {
        total += candy[i];
    }
    free(candy);
    return total;
}