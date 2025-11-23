#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    if (numsSize == 1) return 0;

    int even[100001] = {0};
    int odd[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even[nums[i]]++;
        } else {
            odd[nums[i]]++;
        }
    }

    int maxEven = 0, maxEvenVal = 0;
    int secondMaxEven = 0;
    for (int i = 0; i <= 100000; i++) {
        if (even[i] > maxEven) {
            secondMaxEven = maxEven;
            maxEven = even[i];
            maxEvenVal = i;
        } else if (even[i] > secondMaxEven) {
            secondMaxEven = even[i];
        }
    }

    int maxOdd = 0, maxOddVal = 0;
    int secondMaxOdd = 0;
    for (int i = 0; i <= 100000; i++) {
        if (odd[i] > maxOdd) {
            secondMaxOdd = maxOdd;
            maxOdd = odd[i];
            maxOddVal = i;
        } else if (odd[i] > secondMaxOdd) {
            secondMaxOdd = odd[i];
        }
    }

    if (maxEvenVal != maxOddVal) {
        return numsSize - maxEven - maxOdd;
    } else {
        return numsSize - (maxEven > secondMaxOdd ? maxEven + secondMaxOdd : secondMaxEven + maxOdd);
    }
}