#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int maxFrequencyScore(int* nums, int numsSize) {
    int freq[200001] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 100000]++;
    }

    int max_diff = INT_MIN;
    for (int i = 0; i <= 200000; i++) {
        if (freq[i] > 0) {
            int even_freq = 0;
            int odd_freq = 0;
            for (int j = 0; j <= 200000; j++) {
                if (j != i) {
                    if (freq[j] % 2 == 0 && freq[j] > 0) {
                        even_freq += freq[j];
                    } else if (freq[j] > 0) {
                        odd_freq += freq[j];
                    }
                }
            }
            max_diff = max(max_diff, freq[i] - (even_freq - odd_freq));
        }
    }
    return max_diff;
}