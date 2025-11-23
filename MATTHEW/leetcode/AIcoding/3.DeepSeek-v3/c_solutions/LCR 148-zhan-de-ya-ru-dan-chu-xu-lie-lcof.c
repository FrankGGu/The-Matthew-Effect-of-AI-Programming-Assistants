bool validateBookSequences(int* putIn, int putInSize, int* takeOut, int takeOutSize){
    int* stack = (int*)malloc(putInSize * sizeof(int));
    int top = -1;
    int i = 0, j = 0;

    while (i < putInSize && j < takeOutSize) {
        stack[++top] = putIn[i++];
        while (top >= 0 && stack[top] == takeOut[j]) {
            top--;
            j++;
        }
    }

    free(stack);
    return j == takeOutSize;
}