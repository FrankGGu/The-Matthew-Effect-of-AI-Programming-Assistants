#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPossible(int* nums, int numsSize) {
    int* freq = (int*)malloc(sizeof(int) * (20001));
    int* need = (int*)malloc(sizeof(int) * (20001));
    for (int i = 0; i < 20001; i++) {
        freq[i] = 0;
        need[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 10000]++;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i] + 10000;
        if (freq[num] == 0) continue;

        if (need[num] > 0) {
            need[num]--;
            freq[num]--;
            need[num + 1]++;
        } else if (freq[num] > 0 && freq[num + 1] > 0 && freq[num + 2] > 0) {
            freq[num]--;
            freq[num + 1]--;
            freq[num + 2]--;
            need[num + 3]++;
        } else {
            free(freq);
            free(need);
            return false;
        }
    }

    free(freq);
    free(need);
    return true;
}