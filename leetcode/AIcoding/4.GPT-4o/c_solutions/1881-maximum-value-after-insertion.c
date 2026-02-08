char* maxValue(char* n, int x) {
    int len = strlen(n);
    char* result = (char*)malloc(len + 2);
    int inserted = 0;

    if (n[0] == '-') {
        result[0] = '-';
        for (int i = 1; i < len; i++) {
            if (!inserted && (n[i] - '0') > x) {
                result[i] = x + '0';
                inserted = 1;
            } else {
                result[i + inserted] = n[i];
            }
        }
        if (!inserted) result[len + 1] = x + '0';
    } else {
        for (int i = 0; i < len; i++) {
            if (!inserted && (n[i] - '0') < x) {
                result[i] = x + '0';
                inserted = 1;
            } else {
                result[i + inserted] = n[i];
            }
        }
        if (!inserted) result[len + 1] = x + '0';
    }

    result[len + inserted] = '\0';
    return result;
}