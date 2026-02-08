bool validateStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int* stack = (int*)malloc(pushedSize * sizeof(int));
    int top = -1;
    int i = 0, j = 0;

    while (i < pushedSize) {
        stack[++top] = pushed[i++];
        while (top >= 0 && j < poppedSize && stack[top] == popped[j]) {
            top--;
            j++;
        }
    }

    free(stack);
    return j == poppedSize;
}