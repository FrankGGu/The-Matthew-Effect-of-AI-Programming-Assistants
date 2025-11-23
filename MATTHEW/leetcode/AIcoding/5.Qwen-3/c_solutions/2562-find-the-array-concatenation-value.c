#include <stdio.h>
#include <stdlib.h>

long long findTheArrayConcValue(int* nums, int numsSize) {
    long long value = 0;
    int left = 0;
    int right = numsSize - 1;

    while (left <= right) {
        if (left == right) {
            char* str = (char*)malloc(20 * sizeof(char));
            sprintf(str, "%d", nums[left]);
            value += atoi(str);
            free(str);
        } else {
            char* leftStr = (char*)malloc(20 * sizeof(char));
            char* rightStr = (char*)malloc(20 * sizeof(char));
            sprintf(leftStr, "%d", nums[left]);
            sprintf(rightStr, "%d", nums[right]);
            char* concat = (char*)malloc((strlen(leftStr) + strlen(rightStr) + 1) * sizeof(char));
            strcpy(concat, leftStr);
            strcat(concat, rightStr);
            value += atoi(concat);
            free(leftStr);
            free(rightStr);
            free(concat);
        }
        left++;
        right--;
    }

    return value;
}