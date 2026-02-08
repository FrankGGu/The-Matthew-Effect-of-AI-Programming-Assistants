#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int missingInteger(int* nums, int numsSize) {
    int sum = nums[0];
    int len = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1] + 1) {
            sum += nums[i];
            len++;
        } else {
            break;
        }
    }

    int seen[1001] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= 1000) {
            seen[nums[i]] = 1;
        }
    }

    int result = sum;
    while (result <= 2000 && seen[result - sum + nums[len-1]] == 1) {
        result++;
    }

    while(1){
        int found = 0;
        for(int i = 0; i < numsSize; i++){
            if(nums[i] == result){
                result++;
                found = 1;
                break;
            }
        }
        if(found == 0) break;
    }

    return result;
}