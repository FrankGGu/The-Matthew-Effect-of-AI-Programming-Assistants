#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int totalFruit(int* fruits, int fruitsSize) {
    if (fruitsSize == 0) {
        return 0;
    }

    int* freq = (int*)calloc(fruitsSize, sizeof(int));
    if (freq == NULL) {
        return 0; 
    }

    int left = 0;
    int max_fruits = 0;
    int distinct_count = 0;

    for (int right = 0; right < fruitsSize; right++) {
        if (freq[fruits[right]] == 0) {
            distinct_count++;
        }
        freq[fruits[right]]++;

        while (distinct_count > 2) {
            freq[fruits[left]]--;
            if (freq[fruits[left]] == 0) {
                distinct_count--;
            }
            left++;
        }

        max_fruits = max(max_fruits, right - left + 1);
    }

    free(freq);
    return max_fruits;
}