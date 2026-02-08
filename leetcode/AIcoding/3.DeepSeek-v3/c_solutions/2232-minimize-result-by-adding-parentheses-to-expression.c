int evaluate(char* expr) {
    int left = 0, right = 0;
    char op = '+';
    int i = 0;
    while (expr[i] != '+' && expr[i] != '\0') {
        left = left * 10 + (expr[i] - '0');
        i++;
    }
    op = expr[i++];
    while (expr[i] != '\0') {
        right = right * 10 + (expr[i] - '0');
        i++;
    }
    return left + right;
}

char* minimizeResult(char* expression) {
    int plus_pos = -1;
    int len = strlen(expression);
    for (int i = 0; i < len; i++) {
        if (expression[i] == '+') {
            plus_pos = i;
            break;
        }
    }

    int min_val = INT_MAX;
    int left_paren = -1, right_paren = -1;

    for (int i = 0; i < plus_pos; i++) {
        for (int j = plus_pos + 1; j < len; j++) {
            int left_mul = 1;
            if (i > 0) {
                char temp = expression[i];
                expression[i] = '\0';
                left_mul = atoi(expression);
                expression[i] = temp;
            }

            int left_add = 0;
            char temp1 = expression[plus_pos];
            expression[plus_pos] = '\0';
            left_add = atoi(expression + i);
            expression[plus_pos] = temp1;

            int right_add = 0;
            char temp2 = expression[j + 1];
            expression[j + 1] = '\0';
            right_add = atoi(expression + plus_pos + 1);
            expression[j + 1] = temp2;

            int right_mul = 1;
            if (j < len - 1) {
                right_mul = atoi(expression + j + 1);
            }

            int result = left_mul * (left_add + right_add) * right_mul;
            if (result < min_val) {
                min_val = result;
                left_paren = i;
                right_paren = j;
            }
        }
    }

    char* result_str = (char*)malloc(len + 3);
    int idx = 0;
    for (int i = 0; i < len; i++) {
        if (i == left_paren) {
            result_str[idx++] = '(';
        }
        result_str[idx++] = expression[i];
        if (i == right_paren) {
            result_str[idx++] = ')';
        }
    }
    result_str[idx] = '\0';
    return result_str;
}