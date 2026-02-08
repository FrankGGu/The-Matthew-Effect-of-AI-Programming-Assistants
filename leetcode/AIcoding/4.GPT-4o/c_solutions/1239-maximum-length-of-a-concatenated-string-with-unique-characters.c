int maxLength(char **arr, int arrSize) {
    int maxLen = 0;

    void backtrack(int index, char *current, int currentLen) {
        if (index == arrSize) {
            maxLen = currentLen > maxLen ? currentLen : maxLen;
            return;
        }

        backtrack(index + 1, current, currentLen);

        char *next = arr[index];
        int freq[26] = {0};
        for (int i = 0; i < currentLen; i++) {
            freq[current[i] - 'a']++;
            if (freq[current[i] - 'a'] > 1) return;
        }

        for (int i = 0; next[i]; i++) {
            freq[next[i] - 'a']++;
            if (freq[next[i] - 'a'] > 1) return;
        }

        strcpy(current + currentLen, next);
        backtrack(index + 1, current, currentLen + strlen(next));
    }

    char current[27] = {0};
    backtrack(0, current, 0);
    return maxLen;
}