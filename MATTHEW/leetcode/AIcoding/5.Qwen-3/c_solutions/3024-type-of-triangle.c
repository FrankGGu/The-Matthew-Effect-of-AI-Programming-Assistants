#include <stdio.h>
#include <stdlib.h>

char* triangleType(int* nums, int numsSize) {
    int a = nums[0], b = nums[1], c = nums[2];
    if (a + b <= c || a + c <= b || b + c <= a) {
        return "None";
    }
    if (a == b && b == c) {
        return "Equilateral";
    } else if (a == b || b == c || a == c) {
        return "Isosceles";
    } else {
        return "Scalene";
    }
}