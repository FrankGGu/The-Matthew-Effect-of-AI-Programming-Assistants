#include <stdio.h>
#include <stdlib.h>

int maxArea(int* height, int heightSize) {
    int left = 0;
    int right = heightSize - 1;
    int max_area = 0;
    int current_area;

    while (left < right) {
        current_area = (right - left) * (height[left] < height[right] ? height[left] : height[right]);
        if (current_area > max_area) {
            max_area = current_area;
        }
        if (height[left] < height[right]) {
            left++;
        } else {
            right--;
        }
    }

    return max_area;
}