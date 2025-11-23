int longestValidParentheses(char * s) {
    int max_length = 0;
    int current_length = 0;
    int stack[10000]; 
    int top = -1;
    int last_invalid = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            stack[++top] = i;
        } else {
            if (top == -1) {
                last_invalid = i;
            } else {
                top--;
                if (top == -1) {
                    current_length = i - last_invalid;
                } else {
                    current_length = i - stack[top];
                }
                if (current_length > max_length) {
                    max_length = current_length;
                }
            }
        }
    }

    return max_length;
}