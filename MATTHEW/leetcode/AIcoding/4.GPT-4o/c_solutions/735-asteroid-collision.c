#include <stdlib.h>

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    int* stack = (int*)malloc(asteroidsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        int current = asteroids[i];
        while (top >= 0 && current < 0 && stack[top] > 0) {
            if (stack[top] < -current) {
                top--;
                continue;
            } else if (stack[top] == -current) {
                top--;
            }
            current = 0;
            break;
        }
        if (current != 0) {
            stack[++top] = current;
        }
    }

    *returnSize = top + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = stack[i];
    }

    free(stack);
    return result;
}