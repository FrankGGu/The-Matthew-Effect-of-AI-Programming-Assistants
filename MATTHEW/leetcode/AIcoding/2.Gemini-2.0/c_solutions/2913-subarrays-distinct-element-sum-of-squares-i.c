#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumCounts(int* nums, int numsSize){
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int distinct[101] = {0};
            int count = 0;
            for (int k = i; k <= j; k++) {
                if (distinct[nums[k]] == 0) {
                    distinct[nums[k]] = 1;
                    count++;
                }
            }
            sum += count * count;
        }
    }
    return sum;
}