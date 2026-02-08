int reverseDegree(char* s) {
    int sum = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        sum += (s[i] - 'a' + 1) * (len - i);
    }
    return sum;
}