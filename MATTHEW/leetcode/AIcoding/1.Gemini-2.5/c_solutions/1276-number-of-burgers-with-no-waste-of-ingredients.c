#include <stdlib.h>

int* numOfBurgers(int tomatoSlices, int cheeseSlices, int* returnSize) {
    *returnSize = 0;

    if (tomatoSlices % 2 != 0) {
        return NULL;
    }

    int jumboBurgersNumerator = tomatoSlices - 2 * cheeseSlices;
    int smallBurgersNumerator = 4 * cheeseSlices - tomatoSlices;

    if (jumboBurgersNumerator < 0 || smallBurgersNumerator < 0) {
        return NULL;
    }

    int j = jumboBurgersNumerator / 2;
    int s = smallBurgersNumerator / 2;

    int* result = (int*)malloc(sizeof(int) * 2);
    if (result == NULL) {
        return NULL;
    }

    result[0] = j;
    result[1] = s;
    *returnSize = 2;

    return result;
}