int maximumValue(char** strs, int strsSize) {
    int maxVal = 0;
    for (int i = 0; i < strsSize; i++) {
        char* s = strs[i];
        int hasLetter = 0;
        int len = 0;
        while (s[len]) {
            if (s[len] >= 'a' && s[len] <= 'z') {
                hasLetter = 1;
            }
            len++;
        }
        if (hasLetter) {
            if (len > maxVal) maxVal = len;
        } else {
            int num = 0;
            for (int j = 0; s[j]; j++) {
                num = num * 10 + (s[j] - '0');
            }
            if (num > maxVal) maxVal = num;
        }
    }
    return maxVal;
}