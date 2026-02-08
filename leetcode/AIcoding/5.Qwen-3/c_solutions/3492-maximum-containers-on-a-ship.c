#include <stdio.h>
#include <stdlib.h>

int maxWaterContainer(int* height, int heightSize) {
    int left = 0;
    int right = heightSize - 1;
    int maxArea = 0;

    while (left < right) {
        int width = right - left;
        int currentHeight = height[left] < height[right] ? height[left] : height[right];
        int area = width * currentHeight;
        if (area > maxArea) {
            maxArea = area;
        }

        if (height[left] < height[right]) {
            left++;
        } else {
            right--;
        }
    }

    return maxArea;
}