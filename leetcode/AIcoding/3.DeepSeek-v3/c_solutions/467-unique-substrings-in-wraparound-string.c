int findSubstringInWraproundString(char* p) {
    int len = strlen(p);
    if (len == 0) return 0;

    int count[26] = {0};
    int maxLen = 1;

    for (int i = 0; i < len; i++) {
        if (i > 0 && (p[i] - p[i-1] == 1 || p[i-1] - p[i] == 25)) {
            maxLen++;
        } else {
            maxLen = 1;
        }
        int index = p[i] - 'a';
        count[index] = count[index] > maxLen ? count[index] : maxLen;
    }

    int result = 0;
    for (int i = 0; i < 26; i++) {
        result += count[i];
    }
    return result;
}