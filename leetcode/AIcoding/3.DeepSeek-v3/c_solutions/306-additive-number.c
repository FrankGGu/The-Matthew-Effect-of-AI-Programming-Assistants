bool isAdditiveNumber(char* num) {
    int len = strlen(num);
    for (int i = 1; i <= len / 2; i++) {
        for (int j = 1; j <= (len - i) / 2; j++) {
            if (check(num, i, j)) return true;
        }
    }
    return false;
}

bool check(char* num, int i, int j) {
    int len = strlen(num);
    if ((i > 1 && num[0] == '0') || (j > 1 && num[i] == '0')) return false;

    char* firstStr = (char*)malloc(i + 1);
    char* secondStr = (char*)malloc(j + 1);
    strncpy(firstStr, num, i);
    firstStr[i] = '\0';
    strncpy(secondStr, num + i, j);
    secondStr[j] = '\0';

    long long first = atoll(firstStr);
    long long second = atoll(secondStr);

    free(firstStr);
    free(secondStr);

    char sumStr[25];
    int start = i + j;
    while (start < len) {
        long long sum = first + second;
        sprintf(sumStr, "%lld", sum);
        int sumLen = strlen(sumStr);
        if (start + sumLen > len) return false;
        if (strncmp(num + start, sumStr, sumLen) != 0) return false;
        first = second;
        second = sum;
        start += sumLen;
    }
    return start == len;
}