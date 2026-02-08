int longestContinuousSubstring(char * s) {
    int maxLength = 1, currentLength = 1;
    int n = strlen(s);

    for (int i = 1; i < n; i++) {
        if (s[i] == s[i - 1] + 1) {
            currentLength++;
        } else {
            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
            currentLength = 1;
        }
    }

    return currentLength > maxLength ? currentLength : maxLength;
}