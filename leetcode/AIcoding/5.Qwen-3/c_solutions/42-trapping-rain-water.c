#include <stdio.h>
#include <stdlib.h>

int trap(int* height, int heightSize) {
    if (heightSize <= 2) return 0;

    int left = 0, right = heightSize - 1;
    int left_max = 0, right_max = 0;
    int result = 0;

    while (left < right) {
        if (height[left] < height[right]) {
            if (height[left] >= left_max) {
                left_max = height[left];
            } else {
                result += left_max - height[left];
            }
            left++;
        } else {
            if (height[right] >= right_max) {
                right_max = height[right];
            } else {
                result += right_max - height[right];
            }
            right--;
        }
    }

    return result;
}