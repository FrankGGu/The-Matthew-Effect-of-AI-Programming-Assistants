int calculate(char * s) {
    int len = strlen(s);
    long long sum = 0, current = 0;
    char operation = '+';

    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            current = current * 10 + (s[i] - '0');
        }
        if (!isdigit(s[i]) && s[i] != ' ' || i == len - 1) {
            if (operation == '+') {
                sum += current;
            } else if (operation == '-') {
                sum -= current;
            } else if (operation == '*') {
                sum *= current;
            } else if (operation == '/') {
                sum /= current;
            }
            operation = s[i];
            current = 0;
        }
    }

    return (int)sum;
}