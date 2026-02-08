#include <stdlib.h>

int sumOfUnique(int* nums, int numsSize) {
    int freq[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int sum = 0;
    for (int i = 1; i <= 100; i++) {
        if (freq[i] == 1) {
            sum += i;
        }
    }
    return sum;
}