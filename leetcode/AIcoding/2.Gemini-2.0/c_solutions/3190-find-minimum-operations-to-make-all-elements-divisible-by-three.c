#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize){
    int sum = 0;
    int min1 = 100001;
    int min2 = 100001;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % 3;
        if (nums[i] % 3 == 1) {
            if (nums[i] < min1) {
                min2 = min1;
                min1 = nums[i];
            } else if (nums[i] < min2) {
                min2 = nums[i];
            }
        } else if (nums[i] % 3 == 2) {
            if (nums[i] < min1) {
                min2 = min1;
                min1 = nums[i];
            } else if (nums[i] < min2) {
                min2 = nums[i];
            }
        }
    }

    if (sum == 0) {
        return 0;
    } else if (sum == 1) {
        if (min1 == 100001 && (min2 == 100001 || min2 > 100000))
        {
            return -1;
        }
        if(min1 == 100001)
        {
            return -1;
        }
        if (min2 == 100001)
        {
            return 1;
        }
        int temp = min1 + min2;
        if (temp == 200002) return 1;

        int min_val = min1;
        int temp_min1 = 100001;
        int temp_min2 = 100001;
        for (int i = 0; i < numsSize; i++)
        {
            if(nums[i] % 3 == 2)
            {
                if (nums[i] < temp_min1)
                {
                    temp_min2 = temp_min1;
                    temp_min1 = nums[i];
                }
                else if (nums[i] < temp_min2)
                {
                    temp_min2 = nums[i];
                }
            }
        }
        if(temp_min1 != 100001 && temp_min2 != 100001)
        {
            return (min_val <= (temp_min1 + temp_min2)) ? 1 : 2;
        }
        else
        {
            return 1;
        }

    } else {
        if (min1 == 100001 && (min2 == 100001 || min2 > 100000))
        {
            return -1;
        }
        if(min1 == 100001)
        {
            return -1;
        }
        if (min2 == 100001)
        {
            return 1;
        }
         int temp = min1 + min2;
        if (temp == 200002) return 1;
        int min_val = min1;
        int temp_min1 = 100001;
        int temp_min2 = 100001;
        for (int i = 0; i < numsSize; i++)
        {
            if(nums[i] % 3 == 1)
            {
                if (nums[i] < temp_min1)
                {
                    temp_min2 = temp_min1;
                    temp_min1 = nums[i];
                }
                else if (nums[i] < temp_min2)
                {
                    temp_min2 = nums[i];
                }
            }
        }
        if(temp_min1 != 100001 && temp_min2 != 100001)
        {
             return (min_val <= (temp_min1 + temp_min2)) ? 1 : 2;
        }
        else
        {
            return 1;
        }
    }
}