int longestContinuousSubstring(char * s){
    int maxLen = 0;
    int currentLen = 0;
    if (s == NULL || *s == '\0') {
        return 0;
    }
    maxLen = 1;
    currentLen = 1;
    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i-1] + 1) {
            currentLen++;
        } else {
            currentLen = 1;
        }
        if (currentLen > maxLen) {
            maxLen = currentLen;
        }
    }
    return maxLen;
}