#include <limits.h>

int find132pattern(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int* min_arr = (int*)malloc(numsSize * sizeof(int));
    min_arr[0] = nums[0];

    for (int i = 1; i < numsSize; i++) {
        min_arr[i] = (nums[i] < min_arr[i-1]) ? nums[i] : min_arr[i-1];
    }

    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int j = numsSize - 1; j >= 0; j--) {
        if (nums[j] > min_arr[j]) {
            while (top >= 0 && stack[top] <= min_arr[j]) {
                top--;
            }
            if (top >= 0 && stack[top] < nums[j]) {
                free(min_arr);
                free(stack);
                return 1;
            }
            stack[++top] = nums[j];
        }
    }

    free(min_arr);
    free(stack);
    return 0;
}