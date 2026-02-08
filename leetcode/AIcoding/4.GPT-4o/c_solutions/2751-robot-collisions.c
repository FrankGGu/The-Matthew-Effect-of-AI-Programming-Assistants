int[] robotCollision(int[] robots) {
    int n = sizeof(robots) / sizeof(robots[0]);
    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; i++) {
        int robot = robots[i];
        while (top >= 0 && robot < 0 && stack[top] > 0) {
            if (stack[top] == -robot) {
                top--;
                robot = 0;
            } else if (stack[top] > -robot) {
                robot = 0;
            } else {
                top--;
            }
        }
        if (robot != 0) {
            stack[++top] = robot;
        }
    }

    int* result = (int*)malloc((top + 1) * sizeof(int));
    for (int i = 0; i <= top; i++) {
        result[i] = stack[i];
    }
    free(stack);
    return result;
}