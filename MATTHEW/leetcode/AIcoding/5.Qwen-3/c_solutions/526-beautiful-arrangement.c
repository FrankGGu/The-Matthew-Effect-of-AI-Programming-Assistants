#include <stdio.h>
#include <stdlib.h>

int* createArray(int size) {
    int* arr = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        arr[i] = i + 1;
    }
    return arr;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void backtrack(int* nums, int start, int* count, int n) {
    if (start == n) {
        (*count)++;
        return;
    }

    for (int i = start; i < n; i++) {
        if ((nums[i] % (start + 1) == 0) || ((start + 1) % nums[i] == 0)) {
            swap(&nums[start], &nums[i]);
            backtrack(nums, start + 1, count, n);
            swap(&nums[start], &nums[i]);
        }
    }
}

int beautifulArrangement(int n) {
    int* nums = createArray(n);
    int count = 0;
    backtrack(nums, 0, &count, n);
    free(nums);
    return count;
}