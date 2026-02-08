int count(char* s, char* pattern) {
    int patternLen = strlen(pattern);
    int sLen = strlen(s);
    if (patternLen > sLen) return 0;

    int patternCount[26] = {0};
    for (int i = 0; i < patternLen; i++) {
        patternCount[pattern[i] - 'a']++;
    }

    int result = 0;
    int windowCount[26] = {0};

    for (int i = 0; i < sLen; i++) {
        windowCount[s[i] - 'a']++;

        if (i >= patternLen - 1) {
            int valid = 1;
            for (int j = 0; j < 26; j++) {
                if (windowCount[j] < patternCount[j]) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                result += sLen - i;
            }

            windowCount[s[i - patternLen + 1] - 'a']--;
        }
    }

    return result;
}