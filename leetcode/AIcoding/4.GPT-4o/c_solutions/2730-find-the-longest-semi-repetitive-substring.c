int longestSemiRepetitiveSubstring(char * s) {
    int n = strlen(s), maxLen = 0;
    int left = 0, count = 0;

    for (int right = 0; right < n; right++) {
        if (right > 0 && s[right] == s[right - 1]) {
            count++;
        }

        while (count > 1) {
            if (s[left] == s[left + 1]) {
                count--;
            }
            left++;
        }

        maxLen = fmax(maxLen, right - left + 1);
    }

    return maxLen;
}