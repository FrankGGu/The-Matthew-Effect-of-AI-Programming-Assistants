#include <stdlib.h>
#include <math.h>
#include <time.h>

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
    srand(time(NULL));
    return obj;
}

double* solutionPick(Solution* obj) {
    double* point = (double*)malloc(sizeof(double) * 2);
    double x, y;
    double r_sq = obj->radius * obj->radius;

    while (1) {
        x = obj->x_center - obj->radius + ((double)rand() / RAND_MAX) * (2 * obj->radius);
        y = obj->y_center - obj->radius + ((double)rand() / RAND_MAX) * (2 * obj->radius);

        double dx = x - obj->x_center;
        double dy = y - obj->y_center;

        if (dx * dx + dy * dy <= r_sq) {
            point[0] = x;
            point[1] = y;
            return point;
        }
    }
}

void solutionFree(Solution* obj) {
    free(obj);
}