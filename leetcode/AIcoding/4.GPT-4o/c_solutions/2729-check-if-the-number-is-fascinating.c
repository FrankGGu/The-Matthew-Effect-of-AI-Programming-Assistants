bool isFascinating(int n) {
    char str[100];
    snprintf(str, sizeof(str), "%d%d%d", n, n * 2, n * 3);
    int len = strlen(str);
    if (len != 9) return false;

    int count[10] = {0};
    for (int i = 0; i < len; i++) {
        int digit = str[i] - '0';
        if (digit == 0 || count[digit] > 0) return false;
        count[digit]++;
    }
    return true;
}