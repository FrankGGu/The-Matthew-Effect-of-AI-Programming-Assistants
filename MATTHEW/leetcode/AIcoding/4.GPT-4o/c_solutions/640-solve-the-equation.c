char * solveEquation(char * equation) {
    int A = 0, B = 0;
    int sign = 1, num = 0, i = 0, n = strlen(equation);

    while (i < n) {
        if (equation[i] == '=') {
            sign = -1;
            i++;
            continue;
        }
        if (equation[i] == '+' || equation[i] == '-') {
            sign = (equation[i] == '+') ? 1 : -1;
            i++;
        }
        num = 0;
        while (i < n && isdigit(equation[i])) {
            num = num * 10 + (equation[i] - '0');
            i++;
        }
        if (i < n && equation[i] == 'x') {
            A += sign * (num ? num : 1);
            i++;
        } else {
            B += sign * num;
        }
    }

    if (A == 0) {
        if (B == 0) return "Infinite solutions";
        return "No solution";
    }

    int x = -B / A;
    int remainder = -B % A;
    char *result = (char *)malloc(20 * sizeof(char));
    if (remainder == 0) {
        sprintf(result, "x=%d", x);
    } else {
        sprintf(result, "x=%d/%d", -B, A);
    }

    return result;
}