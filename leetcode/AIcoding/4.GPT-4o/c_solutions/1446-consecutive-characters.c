int countCharacters(char * s) {
    int maxCount = 1, currentCount = 1;
    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i - 1]) {
            currentCount++;
        } else {
            if (currentCount > maxCount) {
                maxCount = currentCount;
            }
            currentCount = 1;
        }
    }
    if (currentCount > maxCount) {
        maxCount = currentCount;
    }
    return maxCount;
}