#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* asteroidCollision(int* asteroids, int asteroidsSize, int* returnSize) {
    int* stack = (int*)malloc(sizeof(int) * asteroidsSize);
    int top = -1;

    for (int i = 0; i < asteroidsSize; i++) {
        bool push = true;
        while (top >= 0 && asteroids[i] < 0 && stack[top] > 0) {
            if (stack[top] < -asteroids[i]) {
                top--;
            } else if (stack[top] == -asteroids[i]) {
                top--;
                push = false;
                break;
            } else {
                push = false;
                break;
            }
        }
        if (push) {
            stack[++top] = asteroids[i];
        }
    }

    *returnSize = top + 1;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i <= top; i++) {
        result[i] = stack[i];
    }
    free(stack);
    return result;
}