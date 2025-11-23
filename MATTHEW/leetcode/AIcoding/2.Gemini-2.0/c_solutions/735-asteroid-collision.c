#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize){
    int* stack = (int*)malloc(asteroidsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        int asteroid = asteroids[i];

        while (top >= 0 && asteroids[stack[top]] > 0 && asteroid < 0) {
            if (asteroids[stack[top]] < -asteroid) {
                top--;
            } else if (asteroids[stack[top]] == -asteroid) {
                top--;
                asteroid = 0;
                break;
            } else {
                asteroid = 0;
                break;
            }
        }

        if (asteroid != 0) {
            stack[++top] = i;
        }
    }

    *returnSize = top + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i <= top; i++) {
        result[i] = asteroids[stack[i]];
    }

    free(stack);
    return result;
}