#include <stdio.h>
#include <stdlib.h>

struct DetectSquares {
    int points[1001][1001];
};

struct DetectSquares* detectSquaresCreate() {
    struct DetectSquares* obj = (struct DetectSquares*)malloc(sizeof(struct DetectSquares));
    for (int i = 0; i < 1001; ++i)
        for (int j = 0; j < 1001; ++j)
            obj->points[i][j] = 0;
    return obj;
}

void detectSquaresAdd(struct DetectSquares* obj, int* point) {
    obj->points[point[0]][point[1]]++;
}

int detectSquaresCount(struct DetectSquares* obj, int* point) {
    int count = 0;
    for (int x = 0; x < 1001; ++x) {
        if (obj->points[x][point[1]] > 0) {
            int side = abs(x - point[0]);
            if (side > 0) {
                count += obj->points[x][point[1]] * obj->points[point[0]][point[1] + side] * obj->points[point[0]][point[1] - side];
            }
        }
    }
    return count;
}

void detectSquaresFree(struct DetectSquares* obj) {
    free(obj);
}