#include <stdio.h>
#include <stdlib.h>

struct Point {
    int x;
    int y;
};

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    int minArea = INT_MAX;
    int hash[10001][10001] = {0};

    for (int i = 0; i < pointsSize; i++) {
        hash[points[i][0]][points[i][1]] = 1;
    }

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i][0] != points[j][0] && points[i][1] != points[j][1]) {
                if (hash[points[i][0]][points[j][1]] && hash[points[j][0]][points[i][1]]) {
                    int area = abs(points[i][0] - points[j][0]) * abs(points[i][1] - points[j][1]);
                    minArea = area < minArea ? area : minArea;
                }
            }
        }
    }

    return minArea == INT_MAX ? 0 : minArea;
}