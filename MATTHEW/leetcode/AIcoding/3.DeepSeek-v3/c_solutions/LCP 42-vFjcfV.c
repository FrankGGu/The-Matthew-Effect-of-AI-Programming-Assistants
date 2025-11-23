#include <stdlib.h>
#include <math.h>

typedef struct {
    double x;
    double y;
    double r;
} Circle;

int cmp(const void* a, const void* b) {
    Circle* c1 = (Circle*)a;
    Circle* c2 = (Circle*)b;
    if (c1->r != c2->r) {
        return c1->r > c2->r ? 1 : -1;
    }
    if (c1->x != c2->x) {
        return c1->x > c2->x ? 1 : -1;
    }
    return c1->y > c2->y ? 1 : -1;
}

int circleGame(int** toys, int toysSize, int* toysColSize, int** circles, int circlesSize, int* circlesColSize, int r) {
    Circle* cs = (Circle*)malloc(toysSize * sizeof(Circle));
    for (int i = 0; i < toysSize; i++) {
        cs[i].x = toys[i][0];
        cs[i].y = toys[i][1];
        cs[i].r = toys[i][2];
    }

    qsort(cs, toysSize, sizeof(Circle), cmp);

    int res = 0;
    for (int i = 0; i < toysSize; i++) {
        if (cs[i].r > r) continue;
        int found = 0;
        for (int j = 0; j < circlesSize; j++) {
            double dx = cs[i].x - circles[j][0];
            double dy = cs[i].y - circles[j][1];
            double dist = sqrt(dx * dx + dy * dy);
            if (dist + cs[i].r <= r) {
                found = 1;
                break;
            }
        }
        if (found) res++;
    }
    free(cs);
    return res;
}