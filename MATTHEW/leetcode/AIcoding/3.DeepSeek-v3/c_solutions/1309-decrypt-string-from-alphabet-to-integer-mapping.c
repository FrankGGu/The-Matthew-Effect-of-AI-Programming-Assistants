char* freqAlphabets(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int idx = 0;

    for (int i = 0; i < len; i++) {
        if (i + 2 < len && s[i + 2] == '#') {
            int num = (s[i] - '0') * 10 + (s[i + 1] - '0');
            result[idx++] = 'a' + num - 1;
            i += 2;
        } else {
            result[idx++] = 'a' + (s[i] - '0') - 1;
        }
    }

    result[idx] = '\0';
    return result;
}