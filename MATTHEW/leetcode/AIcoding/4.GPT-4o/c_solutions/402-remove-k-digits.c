char* removeKdigits(char* num, int k) {
    int len = strlen(num);
    if (len == k) return "0";

    char* stack = (char*)malloc(len + 1);
    int top = 0;

    for (int i = 0; i < len; i++) {
        while (top > 0 && k > 0 && stack[top - 1] > num[i]) {
            top--;
            k--;
        }
        stack[top++] = num[i];
    }

    while (k > 0 && top > 0) {
        top--;
        k--;
    }

    int start = 0;
    while (start < top && stack[start] == '0') start++;

    if (start == top) return "0";

    stack[top] = '\0';
    return strdup(stack + start);
}