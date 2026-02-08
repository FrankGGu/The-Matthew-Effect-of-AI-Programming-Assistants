#include <stdlib.h>

int differenceOfSum(int* nums, int numsSize) {
    int elementSum = 0;
    int digitSum = 0;

    for (int i = 0; i < numsSize; i++) {
        elementSum += nums[i];
        int num = nums[i];
        if (num == 0) {
            digitSum += 0;
        } else {
            while (num > 0) {
                digitSum += num % 10;
                num /= 10;
            }
        }
    }

    return abs(elementSum - digitSum);
}