#include <stdio.h>
#include <stdlib.h>

int minZeroCuboid(int* dimensions, int dimensionsSize) {
    int x = dimensions[0], y = dimensions[1], z = dimensions[2];
    int min = x * y * z;
    for (int i = 0; i < 3; i++) {
        int temp = dimensions[i];
        dimensions[i] = dimensions[0];
        dimensions[0] = temp;
        int area = dimensions[0] * dimensions[1];
        if (area < min) min = area;
        dimensions[0] = dimensions[i];
        dimensions[i] = temp;
    }
    return min;
}