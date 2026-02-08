#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canSortArray(int* nums, int numsSize) {
    int i = 0;
    while (i < numsSize) {
        int j = i;
        int sum = 0;
        while (j < numsSize) {
            int bits = 0;
            int temp = nums[j];
            while (temp > 0) {
                bits += (temp & 1);
                temp >>= 1;
            }
            if (j == i) {
                sum = bits;
            } else {
                int bits2 = 0;
                int temp2 = nums[j];
                while (temp2 > 0) {
                    bits2 += (temp2 & 1);
                    temp2 >>= 1;
                }
                if (sum != bits2) {
                    break;
                }
            }
            j++;
        }
        for (int k = i; k < j - 1; k++) {
            for (int l = i; l < j - 1; l++) {
                if (nums[l] > nums[l + 1]) {
                    int temp = nums[l];
                    nums[l] = nums[l + 1];
                    nums[l + 1] = temp;
                }
            }
        }
        i = j;
    }
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i + 1]) {
            return false;
        }
    }
    return true;
}