#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

int countBeautifulPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int firstDigit_i = 0;
            int temp_i = nums[i];
            while (temp_i >= 10) {
                temp_i /= 10;
            }
            firstDigit_i = temp_i;

            int lastDigit_j = nums[j] % 10;
            if (gcd(firstDigit_i, lastDigit_j) == 1) {
                count++;
            }

            int firstDigit_j = 0;
            int temp_j = nums[j];
            while (temp_j >= 10) {
                temp_j /= 10;
            }
            firstDigit_j = temp_j;

            int lastDigit_i = nums[i] % 10;
            if (gcd(firstDigit_j, lastDigit_i) == 1) {

            } else {

            }
        }
    }

    count = 0;
    for(int i = 0; i < numsSize; i++){
        for(int j = i + 1; j < numsSize; j++){
            int first_i = nums[i];
            while(first_i >= 10){
                first_i /= 10;
            }
            int last_j = nums[j] % 10;
            if(gcd(first_i, last_j) == 1) count++;

             int first_j = nums[j];
            while(first_j >= 10){
                first_j /= 10;
            }
            int last_i = nums[i] % 10;
            if(gcd(first_j, last_i) == 1) count++;
        }
    }
    return count;
}