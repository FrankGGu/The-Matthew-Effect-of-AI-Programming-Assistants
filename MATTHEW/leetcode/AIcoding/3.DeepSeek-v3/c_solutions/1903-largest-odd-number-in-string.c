char* largestOddNumber(char* num) {
    int len = strlen(num);
    for (int i = len - 1; i >= 0; i--) {
        if ((num[i] - '0') % 2 == 1) {
            num[i + 1] = '\0';
            return num;
        }
    }
    return "";
}