char *removeOuterParentheses(char *s) {
    int n = strlen(s);
    char *result = (char *)malloc(n);
    int count = 0, index = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            if (count++ > 0) result[index++] = s[i];
        } else {
            if (--count > 0) result[index++] = s[i];
        }
    }

    result[index] = '\0';
    return result;
}