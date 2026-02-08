#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y;
} Point;

typedef struct {
    int x1, y1, x2, y2;
} Rect;

int maxAreaRect(Point* points, int pointsSize) {
    long long maxArea = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            if (points[i].x >= points[j].x || points[i].y >= points[j].y) continue;
            int x1 = points[j].x;
            int y1 = points[j].y;
            int x2 = points[i].x;
            int y2 = points[i].y;

            int count = 0;
            for(int k = 0; k < pointsSize; k++){
                if(points[k].x > x1 && points[k].x < x2 && points[k].y > y2 && points[k].y < y1){
                   count++;
                   break; 
                }
            }
            if(count == 0){
               long long area = (long long)(x2 - x1) * (long long)(y1 - y2);
               if (area > maxArea) {
                   maxArea = area;
               } 
            }
        }
    }
    return (int)(maxArea > INT_MAX ? INT_MAX : maxArea);
}