#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSymmetricIntegers(char** nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        char* numStr = nums[i];
        int len = strlen(numStr);
        if (len % 2 != 0) continue;
        int half = len / 2;
        int isSymmetric = 1;
        for (int j = 0; j < half; j++) {
            if (numStr[j] != numStr[len - 1 - j]) {
                isSymmetric = 0;
                break;
            }
        }
        if (isSymmetric) count++;
    }
    return count;
}