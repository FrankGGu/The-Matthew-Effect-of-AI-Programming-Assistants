#include <stdlib.h>
#include <string.h>
#include <math.h>

int* distributeCandies(int candies, int num_people, int* returnSize) {
    int* result = (int*)calloc(num_people, sizeof(int));
    *returnSize = num_people;

    int current_candy_amount = 1;
    int person_index = 0;

    while (candies > 0) {
        int give_amount = (candies >= current_candy_amount) ? current_candy_amount : candies;
        result[person_index] += give_amount;
        candies -= give_amount;

        current_candy_amount++;
        person_index = (person_index + 1) % num_people;
    }

    return result;
}