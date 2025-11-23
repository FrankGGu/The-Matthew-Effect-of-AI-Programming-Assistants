int mctFromLeafValues(int* arr, int arrSize) {
    int res = 0;
    int stack[arrSize];
    int top = -1;

    stack[++top] = INT_MAX;

    for (int i = 0; i < arrSize; i++) {
        while (stack[top] <= arr[i]) {
            int mid = stack[top--];
            res += mid * (stack[top] < arr[i] ? stack[top] : arr[i]);
        }
        stack[++top] = arr[i];
    }

    while (top > 1) {
        res += stack[top--] * stack[top];
    }

    return res;
}