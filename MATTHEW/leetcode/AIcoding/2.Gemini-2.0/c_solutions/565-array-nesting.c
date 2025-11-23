#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int arrayNesting(int* nums, int numsSize) {
    int maxLength = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != -1) {
            int currentLength = 0;
            int current = i;
            while (nums[current] != -1) {
                int next = nums[current];
                nums[current] = -1;
                current = next;
                currentLength++;
            }
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }
    return maxLength;
}