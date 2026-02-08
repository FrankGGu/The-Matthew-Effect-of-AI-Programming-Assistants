char * smallestSubsequence(char * s, int k, char letter, int repetition) {
    int n = strlen(s);
    char *result = (char *)malloc((k + 1) * sizeof(char));
    int count = 0, letterCount = 0, j = 0;
    int lastIndex[26] = {0};

    for (int i = 0; i < n; i++) {
        lastIndex[s[i] - 'a'] = i;
    }

    for (int i = 0; i < n; i++) {
        if (s[i] == letter) {
            letterCount++;
        }
        while (j > 0 && j + n - i > k && (result[j - 1] > s[i] || (result[j - 1] == s[i] && letterCount < repetition))) {
            if (result[j - 1] == letter) {
                letterCount--;
            }
            j--;
        }
        if (j < k) {
            result[j++] = s[i];
        }
        if (i == lastIndex[s[i] - 'a']) {
            if (s[i] == letter) {
                letterCount--;
            }
            if (j > 0 && result[j - 1] == s[i]) {
                j--;
            }
        }
    }

    result[k] = '\0';
    return result;
}