#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumImbalanceNumbers(int* nums, int numsSize) {
    int totalImbalance = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int minVal = nums[i];
            int maxVal = nums[i];
            int imbalance = 0;
            int present[101] = {0};
            for (int k = i; k <= j; k++) {
                if (nums[k] < minVal) {
                    minVal = nums[k];
                }
                if (nums[k] > maxVal) {
                    maxVal = nums[k];
                }
                present[nums[k]] = 1;
            }

            int count = 0;
            for(int k = minVal; k <= maxVal; k++){
                if(present[k] == 1){
                    count++;
                }
            }

            if(count > 0){
                imbalance = count - 1;
            }

            totalImbalance += imbalance;
        }
    }
    return totalImbalance;
}