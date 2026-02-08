char* longestPalindrome(char* s) {
    int start = 0, maxLen = 1, len = strlen(s);
    if (len < 2) return s;

    for (int i = 0; i < len; i++) {
        for (int j = 0; j <= 1; j++) {
            int left = i, right = i + j;
            while (left >= 0 && right < len && s[left] == s[right]) {
                left--;
                right++;
            }
            int newLen = right - left - 1;
            if (newLen > maxLen) {
                maxLen = newLen;
                start = left + 1;
            }
        }
    }

    char* result = (char*)malloc((maxLen + 1) * sizeof(char));
    strncpy(result, s + start, maxLen);
    result[maxLen] = '\0';
    return result;
}