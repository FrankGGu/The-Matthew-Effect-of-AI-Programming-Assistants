#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheArrayConcVal(int* nums, int numsSize) {
    int left = 0, right = numsSize - 1;
    long long sum = 0;
    while (left <= right) {
        if (left == right) {
            sum += nums[left];
        } else {
            int num1 = nums[left];
            int num2 = nums[right];
            int digits = 0;
            int temp = num2;
            if(temp == 0) digits = 1;
            else
            {
                while (temp > 0) {
                    temp /= 10;
                    digits++;
                }
            }

            long long combined = num1;
            for (int i = 0; i < digits; i++) {
                combined *= 10;
            }
            combined += num2;
            sum += combined;
        }
        left++;
        right--;
    }
    return (int)sum;
}