char* solveEquation(char* equation) {
    int x_coef = 0, constant = 0;
    int sign = 1, num = 0;
    int is_left = 1;
    int has_num = 0;

    for (int i = 0; equation[i]; i++) {
        char c = equation[i];

        if (c == '=') {
            constant += sign * num;
            sign = 1;
            num = 0;
            has_num = 0;
            is_left = 0;
        } else if (c == 'x') {
            if (!has_num && num == 0) {
                num = 1;
            }
            x_coef += is_left ? sign * num : -sign * num;
            num = 0;
            has_num = 0;
        } else if (c == '+' || c == '-') {
            constant += is_left ? -sign * num : sign * num;
            sign = (c == '+') ? 1 : -1;
            num = 0;
            has_num = 0;
        } else {
            num = num * 10 + (c - '0');
            has_num = 1;
        }
    }

    constant += sign * num;

    if (x_coef == 0) {
        if (constant == 0) {
            return "Infinite solutions";
        } else {
            return "No solution";
        }
    }

    int result = constant / x_coef;

    char* res = (char*)malloc(20 * sizeof(char));
    sprintf(res, "x=%d", result);
    return res;
}