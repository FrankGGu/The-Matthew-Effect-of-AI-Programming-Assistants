int minInsertions(char *s) {
    int left = 0, right = 0, i = 0, n = strlen(s);
    while (i < n) {
        if (s[i] == '(') {
            left++;
            i++;
        } else {
            if (i < n - 1 && s[i] == ')' && s[i + 1] == ')') {
                right++;
                i += 2;
            } else if (s[i] == ')') {
                if (left > 0) {
                    left--;
                } else {
                    right++;
                }
                i++;
            }
        }
    }
    return left + right;
}