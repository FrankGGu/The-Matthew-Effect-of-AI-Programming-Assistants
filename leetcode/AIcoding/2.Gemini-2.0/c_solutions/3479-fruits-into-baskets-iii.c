#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalFruit(int* fruits, int fruitsSize) {
    int max_fruits = 0;
    int start = 0;
    int fruit_count[100001] = {0};
    int fruit_types = 0;

    for (int end = 0; end < fruitsSize; end++) {
        if (fruit_count[fruits[end]] == 0) {
            fruit_types++;
        }
        fruit_count[fruits[end]]++;

        while (fruit_types > 2) {
            fruit_count[fruits[start]]--;
            if (fruit_count[fruits[start]] == 0) {
                fruit_types--;
            }
            start++;
        }

        int current_fruits = end - start + 1;
        if (current_fruits > max_fruits) {
            max_fruits = current_fruits;
        }
    }

    return max_fruits;
}