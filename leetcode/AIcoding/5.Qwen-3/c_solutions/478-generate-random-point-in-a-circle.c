#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    double x;
    double y;
    double radius;
} Solution;

Solution* solutionCreate(double radius, double x_center, double y_center) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->x = x_center;
    obj->y = y_center;
    obj->radius = radius;
    return obj;
}

void solutionFree(Solution* obj) {
    free(obj);
}

double randDouble() {
    return (double)rand() / RAND_MAX;
}

double* randPoint(Solution* obj, int* returnSize) {
    *returnSize = 2;
    double* result = (double*)malloc(2 * sizeof(double));
    double r = sqrt(randDouble()) * obj->radius;
    double theta = 2 * M_PI * randDouble();
    result[0] = obj->x + r * cos(theta);
    result[1] = obj->y + r * sin(theta);
    return result;
}