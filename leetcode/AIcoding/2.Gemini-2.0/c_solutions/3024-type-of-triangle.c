#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * triangleType(int nums[], int numsSize) {
    int a = nums[0], b = nums[1], c = nums[2];
    if (a + b <= c || a + c <= b || b + c <= a) {
        return "Not A Triangle";
    }
    if (a == b && b == c) {
        return "Equilateral";
    } else if (a == b || a == c || b == c) {
        return "Isosceles";
    } else {
        return "Scalene";
    }
}