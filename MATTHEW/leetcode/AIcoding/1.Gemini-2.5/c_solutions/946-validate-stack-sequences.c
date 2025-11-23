#include <stdbool.h>

bool validateStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int stack[pushedSize];
    int top = -1;

    int popped_idx = 0;

    for (int i = 0; i < pushedSize; i++) {
        stack[++top] = pushed[i];

        while (top != -1 && stack[top] == popped[popped_idx]) {
            top--;
            popped_idx++;
        }
    }

    return top == -1;
}