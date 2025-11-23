int lengthOfLongestSubstring(char * s) {
    int charMap[128] = {0};
    int left = 0, right = 0, maxLength = 0;

    while (s[right] != '\0') {
        charMap[s[right]]++;
        while (charMap[s[right]] > 1) {
            charMap[s[left]]--;
            left++;
        }
        maxLength = fmax(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
}