char* maximumOddBinaryNumber(char* s) {
    int count = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] == '1') {
            count++;
        }
    }

    for (int i = 0; i < len - 1; i++) {
        if (count > 1) {
            s[i] = '1';
            count--;
        } else {
            s[i] = '0';
        }
    }

    s[len - 1] = '1';
    return s;
}