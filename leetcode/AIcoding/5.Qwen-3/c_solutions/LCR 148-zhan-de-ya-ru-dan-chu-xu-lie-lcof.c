#include <stdio.h>
#include <stdlib.h>

bool validateBookOrder(int* target, int targetSize, int* putBack, int putBackSize) {
    int i = 0;
    int j = 0;
    int* stack = (int*)malloc(sizeof(int) * putBackSize);
    int top = -1;

    while (i < targetSize) {
        if (j < putBackSize && target[i] == putBack[j]) {
            i++;
            j++;
        } else if (top >= 0 && target[i] == stack[top]) {
            i++;
            top--;
        } else {
            if (j < putBackSize) {
                stack[++top] = putBack[j++];
            } else {
                free(stack);
                return false;
            }
        }
    }

    free(stack);
    return true;
}