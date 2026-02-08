#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* distributeCandies(int candies, int num_people, int* returnSize){
    int* result = (int*)malloc(sizeof(int) * num_people);
    for (int i = 0; i < num_people; i++) {
        result[i] = 0;
    }
    *returnSize = num_people;
    int i = 0;
    int give = 1;
    while (candies > 0) {
        if (candies >= give) {
            result[i % num_people] += give;
            candies -= give;
            give++;
        } else {
            result[i % num_people] += candies;
            candies = 0;
        }
        i++;
    }
    return result;
}