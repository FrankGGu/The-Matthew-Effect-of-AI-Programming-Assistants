bool isValid(char* s) {
    int top = 0;
    char stack[10000];

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == 'c') {
            if (top < 2 || stack[top-1] != 'b' || stack[top-2] != 'a') {
                return false;
            }
            top -= 2;
        } else {
            stack[top++] = s[i];
        }
    }

    return top == 0;
}