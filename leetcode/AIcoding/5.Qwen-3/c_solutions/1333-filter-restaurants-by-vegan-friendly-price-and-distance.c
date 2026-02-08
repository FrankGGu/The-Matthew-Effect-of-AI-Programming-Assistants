#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return y[0] - x[0];
    return y[1] - x[1];
}

int** filterRestaurants(int** restaurants, int restaurantsSize, int* restaurantsColSize, int veganFriendly, int maxPrice, int maxDistance, int* returnSize) {
    int** result = (int**)malloc(sizeof(int*) * restaurantsSize);
    int count = 0;

    for (int i = 0; i < restaurantsSize; i++) {
        int id = restaurants[i][0];
        int rating = restaurants[i][1];
        int vegan = restaurants[i][2];
        int price = restaurants[i][3];
        int distance = restaurants[i][4];

        if (veganFriendly && !vegan) continue;
        if (price > maxPrice) continue;
        if (distance > maxDistance) continue;

        result[count] = (int*)malloc(sizeof(int) * 2);
        result[count][0] = id;
        result[count][1] = rating;
        count++;
    }

    qsort(result, count, sizeof(int*), compare);
    *returnSize = count;
    return result;
}