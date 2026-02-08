int mctFromLeafValues(int* arr, int arrSize) {
    int cost = 0;
    int stack[arrSize];
    int top = -1;

    for (int i = 0; i < arrSize; i++) {
        while (top != -1 && stack[top] <= arr[i]) {
            int mid = stack[top--];
            if (top == -1) {
                cost += mid * arr[i];
            } else {
                cost += mid * (arr[i] < stack[top] ? arr[i] : stack[top]);
            }
        }
        stack[++top] = arr[i];
    }

    while (top > 0) {
        cost += stack[top--] * stack[top];
    }

    return cost;
}