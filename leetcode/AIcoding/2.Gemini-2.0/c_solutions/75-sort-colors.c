#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sortColors(int* nums, int numsSize){
    int low = 0, mid = 0, high = numsSize - 1;
    while (mid <= high) {
        if (nums[mid] == 0) {
            int temp = nums[low];
            nums[low] = nums[mid];
            nums[mid] = temp;
            low++;
            mid++;
        } else if (nums[mid] == 1) {
            mid++;
        } else {
            int temp = nums[high];
            nums[high] = nums[mid];
            nums[mid] = temp;
            high--;
        }
    }
}