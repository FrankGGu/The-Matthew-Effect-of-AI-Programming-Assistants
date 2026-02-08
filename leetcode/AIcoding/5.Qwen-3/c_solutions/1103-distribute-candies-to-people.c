#include <stdio.h>
#include <stdlib.h>

int* distributeCandies(int candies, int num_people, int* returnSize) {
    int* result = (int*)calloc(num_people, sizeof(int));
    int i = 0;
    int give = 1;
    while (candies > 0) {
        if (i >= num_people) i = 0;
        if (give > candies) {
            give = candies;
        }
        result[i] += give;
        candies -= give;
        give++;
        i++;
    }
    *returnSize = num_people;
    return result;
}