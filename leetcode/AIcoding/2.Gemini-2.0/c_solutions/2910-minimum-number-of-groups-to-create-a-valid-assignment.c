#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumGroupsForValidAssignment(int* nums, int numsSize) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int freq[100001] = {0};
    int freqCount = 0;
    for (int i = 1; i <= 100000; i++) {
        if (count[i] > 0) {
            freq[freqCount++] = count[i];
        }
    }

    int minVal = 100001;
    for (int i = 0; i < freqCount; i++) {
        if (freq[i] < minVal) {
            minVal = freq[i];
        }
    }

    int result = numsSize;
    for (int x = minVal; x >= 1; x--) {
        int groups = 0;
        bool possible = true;
        for (int i = 0; i < freqCount; i++) {
            int num = freq[i];
            if (num % (x + 1) == 0) {
                groups += num / (x + 1);
            } else if (num >= x && num % (x+1) <= num/x) {
                groups += (num / (x + 1)) + 1;
            } else {
                possible = false;
                break;
            }
        }
        if (possible) {
            result = groups;
            break;
        }
    }

    return result;
}