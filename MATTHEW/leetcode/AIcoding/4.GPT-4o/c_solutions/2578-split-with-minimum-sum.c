int splitNum(int num) {
    char str[11];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int digits[10] = {0};

    for (int i = 0; i < len; i++) {
        digits[str[i] - '0']++;
    }

    int num1 = 0, num2 = 0;
    int flag = 0;

    for (int i = 0; i < 10; i++) {
        while (digits[i] > 0) {
            if (flag == 0) {
                num1 = num1 * 10 + i;
            } else {
                num2 = num2 * 10 + i;
            }
            digits[i]--;
            flag = 1 - flag;
        }
    }

    return num1 + num2;
}