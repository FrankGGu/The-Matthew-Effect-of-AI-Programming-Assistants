int lengthOfLongestSubstring(char* s) {
    int n = strlen(s);
    if (n == 0) return 0;

    int lastIndex[256];
    memset(lastIndex, -1, sizeof(lastIndex));

    int maxLen = 0;
    int start = 0;

    for (int end = 0; end < n; end++) {
        if (lastIndex[s[end]] >= start) {
            start = lastIndex[s[end]] + 1;
        }
        lastIndex[s[end]] = end;
        maxLen = (end - start + 1 > maxLen) ? end - start + 1 : maxLen;
    }

    return maxLen;
}