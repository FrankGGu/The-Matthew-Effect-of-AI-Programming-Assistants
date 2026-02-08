/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* filterRestaurants(int** restaurants, int restaurantsSize, int* restaurantsColSize, int veganFriendly, int maxPrice, int maxDistance, int* returnSize) {
    int** filtered = malloc(restaurantsSize * sizeof(int*));
    int count = 0;

    for (int i = 0; i < restaurantsSize; i++) {
        int id = restaurants[i][0];
        int rating = restaurants[i][1];
        int vegan = restaurants[i][2];
        int price = restaurants[i][3];
        int distance = restaurants[i][4];

        if ((veganFriendly == 0 || vegan == veganFriendly) && price <= maxPrice && distance <= maxDistance) {
            filtered[count] = malloc(2 * sizeof(int));
            filtered[count][0] = id;
            filtered[count][1] = rating;
            count++;
        }
    }

    for (int i = 0; i < count - 1; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if (filtered[j][1] < filtered[j+1][1] || 
                (filtered[j][1] == filtered[j+1][1] && filtered[j][0] < filtered[j+1][0])) {
                int* temp = filtered[j];
                filtered[j] = filtered[j+1];
                filtered[j+1] = temp;
            }
        }
    }

    int* result = malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        result[i] = filtered[i][0];
        free(filtered[i]);
    }
    free(filtered);

    *returnSize = count;
    return result;
}