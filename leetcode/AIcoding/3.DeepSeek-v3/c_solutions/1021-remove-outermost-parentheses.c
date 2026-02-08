char* removeOuterParentheses(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc(len + 1);
    int count = 0;
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == '(') {
            if (count > 0) {
                result[index++] = s[i];
            }
            count++;
        } else {
            count--;
            if (count > 0) {
                result[index++] = s[i];
            }
        }
    }

    result[index] = '\0';
    return result;
}