#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool verifyStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int stack[pushedSize];
    int stackTop = -1;
    int poppedIndex = 0;

    for (int i = 0; i < pushedSize; i++) {
        stack[++stackTop] = pushed[i];

        while (stackTop >= 0 && stack[stackTop] == popped[poppedIndex]) {
            stackTop--;
            poppedIndex++;
        }
    }

    return stackTop == -1;
}