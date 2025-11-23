#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool twoSum(int* price, int priceSize, int target) {
    int left = 0;
    int right = priceSize - 1;

    while (left < right) {
        int sum = price[left] + price[right];

        if (sum == target) {
            return true;
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }

    return false;
}