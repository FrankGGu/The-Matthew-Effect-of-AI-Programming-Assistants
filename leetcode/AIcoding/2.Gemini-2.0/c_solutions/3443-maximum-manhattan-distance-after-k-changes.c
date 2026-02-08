#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxManhattanDistance(int** points, int pointsSize, int* pointsColSize, int k) {
    int max1 = INT_MIN, max2 = INT_MIN, max3 = INT_MIN, max4 = INT_MIN;
    int min1 = INT_MAX, min2 = INT_MAX, min3 = INT_MAX, min4 = INT_MAX;

    for (int i = 0; i < pointsSize; i++) {
        int x = points[i][0], y = points[i][1];
        max1 = (x + y > max1) ? x + y : max1;
        min1 = (x + y < min1) ? x + y : min1;
        max2 = (x - y > max2) ? x - y : max2;
        min2 = (x - y < min2) ? x - y : min2;
        max3 = (-x + y > max3) ? -x + y : max3;
        min3 = (-x + y < min3) ? -x + y : min3;
        max4 = (-x - y > max4) ? -x - y : max4;
        min4 = (-x - y < min4) ? -x - y : min4;
    }

    int ans1 = max1 - min1 + k;
    int ans2 = max2 - min2 + k;
    int ans3 = max3 - min3 + k;
    int ans4 = max4 - min4 + k;

    int ans = ans1;
    if (ans2 > ans) ans = ans2;
    if (ans3 > ans) ans = ans3;
    if (ans4 > ans) ans = ans4;

    return ans;
}