char *removeTrailingZeros(char *num) {
    int len = strlen(num);
    while (len > 0 && num[len - 1] == '0') {
        len--;
    }
    num[len] = '\0';
    return num;
}