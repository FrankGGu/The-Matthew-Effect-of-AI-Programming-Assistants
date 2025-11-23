#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int distributeCandies(int* candyType, int candyTypeSize) {
    // Sort the array to easily count unique elements
    qsort(candyType, candyTypeSize, sizeof(int), compare);

    int unique_types = 0;
    if (candyTypeSize > 0) {
        unique_types = 1; // If there are candies, there's at least one unique type
        for (int i = 1; i < candyTypeSize; i++) {
            if (candyType[i] != candyType[i-1]) {
                unique_types++;
            }
        }
    }

    // The sister can eat exactly half of the total candies
    int max_candies_sister_can_eat = candyTypeSize / 2;

    // The maximum number of different types she can eat is the minimum of
    // the total unique types available and the maximum number of candies she can eat.
    if (unique_types < max_candies_sister_can_eat) {
        return unique_types;
    } else {
        return max_candies_sister_can_eat;
    }
}