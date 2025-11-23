#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isBoomerang(int** points, int pointsSize, int* pointsColSize){
    int x1 = points[0][0];
    int y1 = points[0][1];
    int x2 = points[1][0];
    int y2 = points[1][1];
    int x3 = points[2][0];
    int y3 = points[2][1];

    return (x1 - x3) * (y2 - y3) != (x2 - x3) * (y1 - y3);
}