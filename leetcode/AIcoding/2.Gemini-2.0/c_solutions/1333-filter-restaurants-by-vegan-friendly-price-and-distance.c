#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* filterRestaurants(int** restaurants, int restaurantsSize, int* restaurantsColSize, int veganFriendly, int maxPrice, int maxDistance, int* returnSize){
    int count = 0;
    for (int i = 0; i < restaurantsSize; i++) {
        if ((restaurants[i][2] >= veganFriendly) && (restaurants[i][3] <= maxPrice) && (restaurants[i][4] <= maxDistance)) {
            count++;
        }
    }

    int* result = (int*)malloc(sizeof(int) * count);
    *returnSize = count;

    int** filteredRestaurants = (int**)malloc(sizeof(int*) * count);
    int index = 0;
    for (int i = 0; i < restaurantsSize; i++) {
        if ((restaurants[i][2] >= veganFriendly) && (restaurants[i][3] <= maxPrice) && (restaurants[i][4] <= maxDistance)) {
            filteredRestaurants[index] = restaurants[i];
            index++;
        }
    }

    for (int i = 0; i < count; i++) {
        for (int j = i + 1; j < count; j++) {
            if (filteredRestaurants[i][1] < filteredRestaurants[j][1] || (filteredRestaurants[i][1] == filteredRestaurants[j][1] && filteredRestaurants[i][0] < filteredRestaurants[j][0])) {
                int* temp = filteredRestaurants[i];
                filteredRestaurants[i] = filteredRestaurants[j];
                filteredRestaurants[j] = temp;
            }
        }
    }

    for (int i = 0; i < count; i++) {
        result[i] = filteredRestaurants[i][0];
    }
    free(filteredRestaurants);
    return result;
}