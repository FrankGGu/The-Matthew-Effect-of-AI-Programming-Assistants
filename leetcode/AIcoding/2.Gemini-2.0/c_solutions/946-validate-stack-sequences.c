#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool validateStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int i = 0, j = 0, top = -1;
    int stack[pushedSize];

    while (i < pushedSize || j < poppedSize) {
        if (top >= 0 && stack[top] == popped[j]) {
            top--;
            j++;
        } else if (i < pushedSize) {
            stack[++top] = pushed[i];
            i++;
        } else {
            return false;
        }
    }
    return true;
}