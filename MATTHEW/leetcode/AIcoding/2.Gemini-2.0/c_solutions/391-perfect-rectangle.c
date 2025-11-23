#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

bool isRectangleCover(int** rectangles, int rectanglesSize, int* rectanglesColSize){
    if (rectanglesSize == 0) return true;

    long long area = 0;
    int minX = rectangles[0][0], minY = rectangles[0][1], maxX = rectangles[0][2], maxY = rectangles[0][3];

    Point points[4];
    points[0].x = rectangles[0][0];
    points[0].y = rectangles[0][1];
    points[1].x = rectangles[0][0];
    points[1].y = rectangles[0][3];
    points[2].x = rectangles[0][2];
    points[2].y = rectangles[0][1];
    points[3].x = rectangles[0][2];
    points[3].y = rectangles[0][3];

    int pointCount = 4;

    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rectangles[i][0], y1 = rectangles[i][1], x2 = rectangles[i][2], y2 = rectangles[i][3];

        area += (long long)(x2 - x1) * (y2 - y1);

        minX = (x1 < minX) ? x1 : minX;
        minY = (y1 < minY) ? y1 : minY;
        maxX = (x2 > maxX) ? x2 : maxX;
        maxY = (y2 > maxY) ? y2 : maxY;

        Point newPoints[4];
        newPoints[0].x = x1;
        newPoints[0].y = y1;
        newPoints[1].x = x1;
        newPoints[1].y = y2;
        newPoints[2].x = x2;
        newPoints[2].y = y1;
        newPoints[3].x = x2;
        newPoints[3].y = y2;

        for (int j = 0; j < 4; j++) {
            bool found = false;
            for (int k = 0; k < pointCount; k++) {
                if (points[k].x == newPoints[j].x && points[k].y == newPoints[j].y) {

                    for(int l = k; l < pointCount - 1; l++){
                        points[l] = points[l+1];
                    }
                    pointCount--;
                    found = true;
                    break;
                }
            }
            if (!found) {
                 points[pointCount].x = newPoints[j].x;
                 points[pointCount].y = newPoints[j].y;
                pointCount++;
            }
        }
    }

    if (pointCount != 4) return false;

    int topLeftX = minX, topLeftY = maxY;
    int topRightX = maxX, topRightY = maxY;
    int bottomLeftX = minX, bottomLeftY = minY;
    int bottomRightX = maxX, bottomRightY = minY;

    bool topLeftFound = false, topRightFound = false, bottomLeftFound = false, bottomRightFound = false;

    for(int i = 0; i < 4; i++){
        if(points[i].x == topLeftX && points[i].y == topLeftY){
            topLeftFound = true;
        } else if(points[i].x == topRightX && points[i].y == topRightY){
            topRightFound = true;
        } else if(points[i].x == bottomLeftX && points[i].y == bottomLeftY){
            bottomLeftFound = true;
        } else if(points[i].x == bottomRightX && points[i].y == bottomRightY){
            bottomRightFound = true;
        }
    }

    if(!topLeftFound || !topRightFound || !bottomLeftFound || !bottomRightFound) return false;

    return area == (long long)(maxX - minX) * (maxY - minY);
}