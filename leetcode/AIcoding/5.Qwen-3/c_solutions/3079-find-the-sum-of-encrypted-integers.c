#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int encrypt(int num) {
    char str[12];
    sprintf(str, "%d", num);
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        str[i] = '9';
    }
    return atoi(str);
}

int sumOfEncryptedNumbers(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += encrypt(nums[i]);
    }
    return sum;
}