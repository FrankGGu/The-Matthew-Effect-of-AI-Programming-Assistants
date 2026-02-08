int characterReplacement(char* s, int k) {
    int count[26] = {0};
    int maxCount = 0;
    int left = 0;
    int maxLength = 0;

    for (int right = 0; s[right] != '\0'; right++) {
        count[s[right] - 'A']++;
        maxCount = (count[s[right] - 'A'] > maxCount) ? count[s[right] - 'A'] : maxCount;

        while (right - left + 1 - maxCount > k) {
            count[s[left] - 'A']--;
            left++;
        }

        maxLength = (right - left + 1 > maxLength) ? right - left + 1 : maxLength;
    }

    return maxLength;
}