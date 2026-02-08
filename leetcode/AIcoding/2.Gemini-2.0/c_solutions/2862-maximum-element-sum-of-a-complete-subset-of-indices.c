#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumSum(int* nums, int numsSize) {
    int maxSum = 0;
    for (int i = 0; i < numsSize; i++) {
        long long index = (long long)i + 1;
        long long root = (long long)sqrt(index);
        if (root * root == index) {
            maxSum += nums[i];
        }
    }

    for (int i = 1; i < numsSize; i++) {
        int currentSum = 0;
        for (int j = 0; j < numsSize; j++) {
            long long index = (long long)j + 1;
            long long root = (long long)sqrt(index);
            if (root * root == index) {
                currentSum += nums[j];
            }
        }

        for (int k = 1; k <= sqrt(numsSize); k++) {
            int current_sum = 0;
            for (int j = 0; j < numsSize; j++) {
                long long index = (long long)j + 1;
                long long root = (long long)sqrt(index);
                if (root * root == index && (root % k == 0)) {
                    current_sum += nums[j];
                }
            }
            if (current_sum > maxSum) {
                maxSum = current_sum;
            }
        }
        break;
    }

    int ans = 0;
    for(int i=1; i<=sqrt(numsSize); i++){
        int sum = 0;
        for(int j=0; j<numsSize; j++){
            if(sqrt(j+1) == (int)sqrt(j+1) && (int)sqrt(j+1) % i == 0){
                sum += nums[j];
            }
        }
        if(sum > ans) ans = sum;
    }

    return ans;
}