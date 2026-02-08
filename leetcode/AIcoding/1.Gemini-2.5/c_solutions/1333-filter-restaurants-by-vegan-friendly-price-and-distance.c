#include <stdlib.h>

typedef struct {
    int id;
    int rating;
} FilteredRestaurant;

int compareRestaurants(const void* a, const void* b) {
    FilteredRestaurant* r1 = (FilteredRestaurant*)a;
    FilteredRestaurant* r2 = (FilteredRestaurant*)b;

    if (r1->rating != r2->rating) {
        return r2->rating - r1->rating;
    }
    return r2->id - r1->id;
}

int* filterRestaurants(int** restaurants, int restaurantsSize, int* restaurantsColSize, int veganFriendly, int maxPrice, int maxDistance, int* returnSize) {
    FilteredRestaurant* filteredList = (FilteredRestaurant*)malloc(restaurantsSize * sizeof(FilteredRestaurant));
    int filteredCount = 0;

    for (int i = 0; i < restaurantsSize; i++) {
        int id = restaurants[i][0];
        int rating = restaurants[i][1];
        int currentVeganFriendly = restaurants[i][2];
        int price = restaurants[i][3];
        int distance = restaurants[i][4];

        if (veganFriendly == 1 && currentVeganFriendly == 0) {
            continue;
        }
        if (price > maxPrice) {
            continue;
        }
        if (distance > maxDistance) {
            continue;
        }

        filteredList[filteredCount].id = id;
        filteredList[filteredCount].rating = rating;
        filteredCount++;
    }

    qsort(filteredList, filteredCount, sizeof(FilteredRestaurant), compareRestaurants);

    int* result = (int*)malloc(filteredCount * sizeof(int));
    for (int i = 0; i < filteredCount; i++) {
        result[i] = filteredList[i].id;
    }

    *returnSize = filteredCount;

    free(filteredList);

    return result;
}