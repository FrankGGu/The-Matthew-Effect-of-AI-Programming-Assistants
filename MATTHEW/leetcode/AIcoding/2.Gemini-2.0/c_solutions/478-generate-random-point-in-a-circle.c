#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    double radius;
    double x_center;
    double y_center;
} Solution;

Solution* solutionCreate(double radius, double x_center, double y_center) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->radius = radius;
    obj->x_center = x_center;
    obj->y_center = y_center;
    return obj;
}

double* solutionRandPoint(Solution* obj, int* retSize) {
    double u, v, r, theta, x, y;
    double* res = (double*)malloc(2 * sizeof(double));
    *retSize = 2;

    do {
        u = (double)rand() / RAND_MAX * 2 - 1;
        v = (double)rand() / RAND_MAX * 2 - 1;
        r = u * u + v * v;
    } while (r > 1);

    theta = 2 * M_PI * ((double)rand() / RAND_MAX);
    x = sqrt(r) * cos(theta) * obj->radius + obj->x_center;
    y = sqrt(r) * sin(theta) * obj->radius + obj->y_center;

    res[0] = x;
    res[1] = y;

    return res;
}

void solutionFree(Solution* obj) {
    free(obj);
}