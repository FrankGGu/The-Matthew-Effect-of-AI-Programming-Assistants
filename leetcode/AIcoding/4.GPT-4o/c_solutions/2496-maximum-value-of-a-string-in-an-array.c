int maximumValue(char ** strs, int strsSize) {
    int maxValue = 0;
    for (int i = 0; i < strsSize; i++) {
        int isNumber = 1;
        for (int j = 0; strs[i][j] != '\0'; j++) {
            if (strs[i][j] < '0' || strs[i][j] > '9') {
                isNumber = 0;
                break;
            }
        }
        int value = isNumber ? atoi(strs[i]) : strlen(strs[i]);
        if (value > maxValue) {
            maxValue = value;
        }
    }
    return maxValue;
}