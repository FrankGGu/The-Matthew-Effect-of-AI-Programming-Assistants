int lengthOfLongestSubstring(char * s) {
    int map[128] = {0};
    int left = 0, maxLength = 0;
    for (int right = 0; s[right] != '\0'; right++) {
        if (map[s[right]] > 0) {
            while (s[left] != s[right]) {
                map[s[left]] = 0;
                left++;
            }
            left++;
        }
        map[s[right]]++;
        maxLength = (maxLength > (right - left + 1)) ? maxLength : (right - left + 1);
    }
    return maxLength;
}