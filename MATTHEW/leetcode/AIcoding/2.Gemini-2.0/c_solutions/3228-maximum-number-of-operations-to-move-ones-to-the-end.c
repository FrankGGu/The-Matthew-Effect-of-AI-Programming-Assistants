#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxOperations(int* nums, int numsSize) {
    int left = 0;
    int right = numsSize - 1;
    int count = 0;

    while (left < right) {
        if (nums[left] + nums[right] == 1) {
            left++;
            right--;
            count++;
        } else if (nums[left] + nums[right] == 0) {

            int found = 0;
            for(int i = left + 1; i < right; i++){
                if (nums[i] + nums[right] == 1){
                    left = i;
                    right--;
                    count++;
                    found = 1;
                    break;
                }
            }
            if (!found){
                right--;
            }

        }
        else
        {
             int found = 0;
            for(int i = left + 1; i < right; i++){
                if (nums[left] + nums[i] == 1){
                    right = i;
                    left++;
                    count++;
                    found = 1;
                    break;
                }
            }
            if (!found){
                left++;
            }
        }
    }

    return count;
}