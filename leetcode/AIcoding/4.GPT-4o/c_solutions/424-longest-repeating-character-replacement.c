int characterReplacement(char * s, int k) {
    int count[26] = {0};
    int maxCount = 0, left = 0, maxLength = 0;

    for (int right = 0; s[right] != '\0'; right++) {
        count[s[right] - 'A']++;
        maxCount = fmax(maxCount, count[s[right] - 'A']);

        while (right - left + 1 - maxCount > k) {
            count[s[left] - 'A']--;
            left++;
        }

        maxLength = fmax(maxLength, right - left + 1);
    }

    return maxLength;
}