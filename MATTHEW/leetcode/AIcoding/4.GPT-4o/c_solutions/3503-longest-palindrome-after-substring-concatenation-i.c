char* longestPalindrome(char* s) {
    int n = strlen(s);
    if (n < 1) return "";

    int start = 0, maxLen = 1;
    for (int i = 0; i < n; i++) {
        int len1 = expandAroundCenter(s, n, i, i);
        int len2 = expandAroundCenter(s, n, i, i + 1);
        int len = fmax(len1, len2);
        if (len > maxLen) {
            maxLen = len;
            start = i - (maxLen - 1) / 2;
        }
    }

    char* result = (char*)malloc((maxLen + 1) * sizeof(char));
    strncpy(result, s + start, maxLen);
    result[maxLen] = '\0';
    return result;
}

int expandAroundCenter(char* s, int n, int left, int right) {
    while (left >= 0 && right < n && s[left] == s[right]) {
        left--;
        right++;
    }
    return right - left - 1;
}