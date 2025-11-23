char * maximumOddBinaryNumber(char * s) {
    int count1 = 0, count0 = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '1') count1++;
        else count0++;
    }
    char *result = (char *)malloc(count1 + count0 + 2);
    for (int i = 0; i < count1 - 1; i++) {
        result[i] = '1';
    }
    for (int i = count1 - 1; i < count1 + count0; i++) {
        result[i] = '0';
    }
    result[count1 + count0] = '1';
    result[count1 + count0 + 1] = '\0';
    return result;
}