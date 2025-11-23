#include <stdio.h>
#include <stdlib.h>

int verifyPostorder(int* postorder, int postorderSize) {
    int* stack = (int*)malloc(postorderSize * sizeof(int));
    int top = -1;
    int root = INT_MAX;

    for (int i = 0; i < postorderSize; i++) {
        if (postorder[i] > root) {
            return 0;
        }
        while (top >= 0 && postorder[i] > stack[top]) {
            root = stack[top--];
        }
        stack[++top] = postorder[i];
    }

    free(stack);
    return 1;
}