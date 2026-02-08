#include <stdbool.h>

int arithmeticTriplets(int* nums, int numsSize, int diff) {
    bool present[201] = {false};
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = true;
    }

    for (int i = 0; i < numsSize; i++) {
        int first = nums[i];
        int second = first + diff;
        int third = second + diff;

        if (second <= 200 && present[second]) {
            if (third <= 200 && present[third]) {
                count++;
            }
        }
    }

    return count;
}