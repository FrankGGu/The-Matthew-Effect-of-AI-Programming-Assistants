int lengthOfLongestSubstring(char* s) {
    int n = strlen(s);
    int maxLen = 0;
    int left = 0;
    int charIndex[128];
    memset(charIndex, -1, sizeof(charIndex));

    for (int right = 0; right < n; right++) {
        if (charIndex[s[right]] >= left) {
            left = charIndex[s[right]] + 1;
        }
        charIndex[s[right]] = right;
        int currentLen = right - left + 1;
        if (currentLen > maxLen) {
            maxLen = currentLen;
        }
    }

    return maxLen;
}