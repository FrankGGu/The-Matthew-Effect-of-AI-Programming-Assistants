#include <stdlib.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int candy(int* ratings, int ratingsSize) {
    if (ratingsSize == 0) {
        return 0;
    }

    int* candies = (int*)malloc(ratingsSize * sizeof(int));
    if (candies == NULL) {
        return 0;
    }

    for (int i = 0; i < ratingsSize; i++) {
        candies[i] = 1;
    }

    for (int i = 1; i < ratingsSize; i++) {
        if (ratings[i] > ratings[i - 1]) {
            candies[i] = candies[i - 1] + 1;
        }
    }

    for (int i = ratingsSize - 2; i >= 0; i--) {
        if (ratings[i] > ratings[i + 1]) {
            candies[i] = max(candies[i], candies[i + 1] + 1);
        }
    }

    int totalCandies = 0;
    for (int i = 0; i < ratingsSize; i++) {
        totalCandies += candies[i];
    }

    free(candies);
    return totalCandies;
}