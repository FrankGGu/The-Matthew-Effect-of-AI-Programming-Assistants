#include <stdio.h>
#include <stdlib.h>

bool validateStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int* stack = (int*)malloc(pushedSize * sizeof(int));
    int top = -1;
    int i = 0;

    for (int j = 0; j < pushedSize; j++) {
        stack[++top] = pushed[j];
        while (top >= 0 && stack[top] == popped[i]) {
            top--;
            i++;
        }
    }

    free(stack);
    return i == poppedSize;
}