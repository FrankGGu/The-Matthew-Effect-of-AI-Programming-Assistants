int scoreOfParentheses(char* s) {
    int stack[50];
    int top = -1;
    int score = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            stack[++top] = -1;
        } else {
            if (stack[top] == -1) {
                stack[top] = 1;
            } else {
                int inner = 0;
                while (stack[top] != -1) {
                    inner += stack[top--];
                }
                stack[top] = inner * 2;
            }
        }
    }

    while (top != -1) {
        score += stack[top--];
    }

    return score;
}