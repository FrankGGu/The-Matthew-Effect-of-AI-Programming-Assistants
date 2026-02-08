#include <stdlib.h>
#include <math.h>

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

double* solutionRandPoint(Solution* obj, int* returnSize) {
    *returnSize = 2;
    double* point = (double*)malloc(2 * sizeof(double));

    double theta = 2.0 * M_PI * ((double)rand() / RAND_MAX);
    double r = sqrt((double)rand() / RAND_MAX) * obj->radius;

    point[0] = obj->x_center + r * cos(theta);
    point[1] = obj->y_center + r * sin(theta);

    return point;
}

void solutionFree(Solution* obj) {
    free(obj);
}