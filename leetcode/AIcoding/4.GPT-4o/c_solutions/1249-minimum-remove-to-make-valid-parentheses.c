char * minRemoveToMakeValid(char * s) {
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    int balance = 0, removeCount = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            balance++;
        } else if (s[i] == ')') {
            if (balance == 0) {
                removeCount++;
            } else {
                balance--;
            }
        }
    }

    int j = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            if (removeCount > 0) {
                removeCount--;
                continue;
            }
            balance++;
        } else if (s[i] == ')') {
            if (balance == 0) {
                continue;
            }
            balance--;
        }
        result[j++] = s[i];
    }
    result[j] = '\0';
    return result;
}