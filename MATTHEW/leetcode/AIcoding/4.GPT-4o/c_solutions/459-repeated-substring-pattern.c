bool repeatedSubstringPattern(char * s) {
    int len = strlen(s);
    for (int i = 1; i <= len / 2; i++) {
        if (len % i == 0) {
            int repeat = len / i;
            char pattern[i + 1];
            strncpy(pattern, s, i);
            pattern[i] = '\0';
            char constructed[len + 1];
            constructed[0] = '\0';
            for (int j = 0; j < repeat; j++) {
                strcat(constructed, pattern);
            }
            if (strcmp(constructed, s) == 0) {
                return true;
            }
        }
    }
    return false;
}