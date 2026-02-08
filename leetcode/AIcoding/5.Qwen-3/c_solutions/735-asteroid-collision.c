#include <stdio.h>
#include <stdlib.h>

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    int* stack = (int*)malloc(asteroidsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        int current = asteroids[i];
        int collide = 1;

        while (top >= 0 && stack[top] > 0 && current < 0) {
            if (stack[top] < -current) {
                top--;
            } else if (stack[top] == -current) {
                top--;
                collide = 0;
                break;
            } else {
                collide = 0;
                break;
            }
        }

        if (collide) {
            stack[++top] = current;
        }
    }

    *returnSize = top + 1;
    return stack;
}