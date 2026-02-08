int maximumLengthSubstring(char* s) {
    int count[26] = {0};
    int left = 0, right = 0;
    int maxLen = 0;

    while (s[right] != '\0') {
        count[s[right] - 'a']++;

        while (count[s[right] - 'a'] > 2) {
            count[s[left] - 'a']--;
            left++;
        }

        maxLen = (right - left + 1) > maxLen ? (right - left + 1) : maxLen;
        right++;
    }

    return maxLen;
}