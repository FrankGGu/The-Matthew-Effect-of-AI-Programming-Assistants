#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int guardCastle(int* height, int heightSize) {
    if (heightSize <= 1) {
        return heightSize;
    }

    int guards = 0;
    int i = 0;
    while (i < heightSize) {
        guards++;
        int j = i + 1;
        while (j < heightSize && height[j] <= height[i]) {
            j++;
        }
        if (j == heightSize) {
            i++;
        } else {
            int k = j + 1;
            while (k < heightSize && height[k] <= height[j]) {
                k++;
            }
            if (k == heightSize) {
                i = j;
            } else {
                if (height[k - 1] >= height[i]) {
                    i = k - 1;
                } else {
                    i = j;
                }
            }
        }
    }

    return guards;
}