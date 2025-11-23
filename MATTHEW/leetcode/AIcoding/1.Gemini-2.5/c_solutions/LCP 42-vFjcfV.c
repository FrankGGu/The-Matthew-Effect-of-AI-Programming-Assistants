#include <stdlib.h>

int* toyHoop(int num, int radius, int** toys, int toysSize, int* toysColSize, int** hoops, int hoopsSize, int* hoopsColSize, int* returnSize) {
    int* ans = (int*)malloc(sizeof(int) * hoopsSize);
    if (ans == NULL) {
        *returnSize = 0;
        return NULL;
    }

    long long radiusSq = (long long)radius * radius;

    for (int j = 0; j < hoopsSize; j++) {
        int hoop_x = hoops[j][0];
        int hoop_y = hoops[j][1];
        int covered_toys_count = 0;

        for (int i = 0; i < toysSize; i++) {
            int toy_x = toys[i][0];
            int toy_y = toys[i][1];

            long long dx = (long long)toy_x - hoop_x;
            long long dy = (long long)toy_y - hoop_y;
            long long distSq = dx * dx + dy * dy;

            if (distSq <= radiusSq) {
                covered_toys_count++;
            }
        }
        ans[j] = covered_toys_count;
    }

    *returnSize = hoopsSize;
    return ans;
}