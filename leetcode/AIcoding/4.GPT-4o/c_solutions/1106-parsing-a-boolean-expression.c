bool parseBoolExpr(char * expression) {
    char stack[1000];
    int top = -1;
    int len = strlen(expression);

    for (int i = 0; i < len; i++) {
        if (expression[i] == ',') continue;
        if (expression[i] == 't' || expression[i] == 'f') {
            stack[++top] = expression[i];
        } else if (expression[i] == '!') {
            stack[++top] = '!';
        } else if (expression[i] == '&' || expression[i] == '|') {
            int val = (expression[i] == '&') ? 1 : 0;
            i++; // skip '('
            bool result = (val == 1);
            while (expression[i] != ')') {
                if (expression[i] == 't') {
                    result = result && true;
                } else if (expression[i] == 'f') {
                    result = result && false;
                }
                if (expression[i] == ',') {
                    i++;
                    continue;
                }
                i++;
            }
            stack[++top] = result ? 't' : 'f';
        } else if (expression[i] == '(') {
            continue;
        }
    }

    return stack[top] == 't';
}