#include <stdio.h>
#include <stdlib.h>

struct Restaurant {
    int id;
    int veganFriendly;
    int price;
    int distance;
};

int cmp(const void *a, const void *b) {
    struct Restaurant *restA = (struct Restaurant *)a;
    struct Restaurant *restB = (struct Restaurant *)b;
    if (restA->veganFriendly != restB->veganFriendly) {
        return restB->veganFriendly - restA->veganFriendly;
    }
    if (restA->price != restB->price) {
        return restA->price - restB->price;
    }
    return restA->distance - restB->distance;
}

int* filterRestaurants(struct Restaurant* restaurants, int restaurantsSize, int veganFriendly, int maxPrice, int maxDistance, int* returnSize) {
    struct Restaurant* filtered = malloc(restaurantsSize * sizeof(struct Restaurant));
    int count = 0;

    for (int i = 0; i < restaurantsSize; i++) {
        if ((veganFriendly == 0 || restaurants[i].veganFriendly == 1) && restaurants[i].price <= maxPrice && restaurants[i].distance <= maxDistance) {
            filtered[count++] = restaurants[i];
        }
    }

    qsort(filtered, count, sizeof(struct Restaurant), cmp);

    int* result = malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        result[i] = filtered[i].id;
    }

    free(filtered);
    *returnSize = count;
    return result;
}