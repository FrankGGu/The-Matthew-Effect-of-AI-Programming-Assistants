char* removeKdigits(char* num, int k) {
    int len = strlen(num);
    if (k == len) return "0";

    char* stack = malloc(len + 1);
    int top = -1;

    for (int i = 0; i < len; i++) {
        while (k > 0 && top >= 0 && stack[top] > num[i]) {
            top--;
            k--;
        }
        stack[++top] = num[i];
    }

    top -= k;

    int start = 0;
    while (start <= top && stack[start] == '0') {
        start++;
    }

    if (start > top) {
        free(stack);
        return "0";
    }

    stack[top + 1] = '\0';
    char* result = malloc(top - start + 2);
    strcpy(result, stack + start);
    free(stack);

    return result;
}