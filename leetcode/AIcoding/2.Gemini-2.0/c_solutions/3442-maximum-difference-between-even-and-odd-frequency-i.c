#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxDifferenceI(int* nums, int numsSize) {
    int freq[201] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 100]++;
    }
    int even_sum = 0;
    int odd_sum = 0;
    for (int i = 0; i <= 200; i++) {
        if (freq[i] > 0) {
            if (freq[i] % 2 == 0) {
                even_sum += freq[i];
            } else {
                odd_sum += freq[i];
            }
        }
    }
    return even_sum - odd_sum;
}