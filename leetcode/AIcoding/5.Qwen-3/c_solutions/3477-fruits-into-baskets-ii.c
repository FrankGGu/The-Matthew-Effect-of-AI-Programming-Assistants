#include <stdio.h>
#include <stdlib.h>

int totalFruit(int* fruits, int fruitsSize) {
    int left = 0;
    int maxFruits = 0;
    int count[1000] = {0};
    int unique = 0;

    for (int right = 0; right < fruitsSize; right++) {
        if (count[fruits[right]] == 0) {
            unique++;
        }
        count[fruits[right]]++;

        while (unique > 2) {
            count[fruits[left]]--;
            if (count[fruits[left]] == 0) {
                unique--;
            }
            left++;
        }

        maxFruits = (maxFruits > (right - left + 1)) ? maxFruits : (right - left + 1);
    }

    return maxFruits;
}