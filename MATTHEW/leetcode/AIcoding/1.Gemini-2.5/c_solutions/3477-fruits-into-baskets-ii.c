#include <stdlib.h>

int totalFruits(int* fruits, int fruitsSize) {
    if (fruitsSize == 0) {
        return 0;
    }

    int* counts = (int*)calloc(fruitsSize, sizeof(int));
    if (counts == NULL) {
        return 0;
    }

    int left = 0;
    int max_fruits = 0;
    int distinct_count = 0;

    for (int right = 0; right < fruitsSize; ++right) {
        int current_fruit_type = fruits[right];

        if (counts[current_fruit_type] == 0) {
            distinct_count++;
        }
        counts[current_fruit_type]++;

        while (distinct_count > 2) {
            int left_fruit_type = fruits[left];
            counts[left_fruit_type]--;
            if (counts[left_fruit_type] == 0) {
                distinct_count--;
            }
            left++;
        }

        if (right - left + 1 > max_fruits) {
            max_fruits = right - left + 1;
        }
    }

    free(counts);
    return max_fruits;
}