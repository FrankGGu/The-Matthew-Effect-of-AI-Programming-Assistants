#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSeconds(int* nums, int numsSize) {
    int maxFreq = 0;
    int* freq = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    int maxDist = 0;
    for (int i = 1; i <= 1000; i++) {
        if (freq[i] > 0) {
            int first = -1, last = -1;
            for (int j = 0; j < numsSize; j++) {
                if (nums[j] == i) {
                    if (first == -1) {
                        first = j;
                    }
                    last = j;
                }
            }

            int currentDist = 0;
            int prev = first;
            for(int j = first + 1; j < numsSize; j++){
                if(nums[j] == i){
                    currentDist = (j - prev - 1);
                    maxDist = (currentDist > maxDist) ? currentDist : maxDist;
                    prev = j;
                }
            }

            for(int j = 0; j < first; j++){
                if(nums[j] == i){
                    currentDist = (j + numsSize - prev - 1);
                    maxDist = (currentDist > maxDist) ? currentDist : maxDist;
                    prev = j;
                }
            }
        }
    }

    free(freq);
    return (maxDist + 1) / 2;
}