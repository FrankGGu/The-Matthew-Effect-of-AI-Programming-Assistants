bool checkBalancedString(char* s) {
    int minCount = 0, maxCount = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            minCount++;
            maxCount++;
        } else if (s[i] == ')') {
            minCount--;
            maxCount--;
        } else {
            minCount--;
            maxCount++;
        }

        if (maxCount < 0) return false;
        if (minCount < 0) minCount = 0;
    }
    return minCount == 0;
}