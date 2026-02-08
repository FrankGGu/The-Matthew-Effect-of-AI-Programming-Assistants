#include <stdlib.h> // For malloc, free

int* nextGreaterElement(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* ans = (int*)malloc(sizeof(int) * numsSize);
    for (int i = 0; i < numsSize; ++i) {
        ans[i] = -1;
    }

    int* s1_arr = (int*)malloc(sizeof(int) * numsSize);
    int s1_top = -1; 

    int* s2_arr = (int*)malloc(sizeof(int) * numsSize);
    int s2_top = -1; 

    int* temp_to_s2_arr = (int*)malloc(sizeof(int) * numsSize);
    int temp_to_s2_count = 0;

    for (int i = 0; i < numsSize; ++i) {
        int curr_val = nums[i];

        while (s2_top != -1 && nums[s2_arr[s2_top]] < curr_val) {
            ans[s2_arr[s2_top]] = curr_val;
            s2_top--;
        }

        temp_to_s2_count = 0; 
        while (s1_top != -1 && nums[s1_arr[s1_top]] < curr_val) {
            temp_to_s2_arr[temp_to_s2_count++] = s1_arr[s1_top];
            s1_top--;
        }

        s1_arr[++s1_top] = i;

        for (int k = temp_to_s2_count - 1; k >= 0; --k) {
            s2_arr[++s2_top] = temp_to_s2_arr[k];
        }
    }

    free(s1_arr);
    free(s2_arr);
    free(temp_to_s2_arr);

    return ans;
}