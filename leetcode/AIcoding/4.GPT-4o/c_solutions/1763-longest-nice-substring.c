int longestNiceSubstring(char * s) {
    int n = strlen(s);
    int maxLength = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= n; j++) {
            char seen[128] = {0};
            int valid = 1;
            for (int k = i; k < j; k++) {
                seen[s[k]]++;
            }
            for (int k = 'A'; k <= 'Z'; k++) {
                if (seen[k] > 0 && seen[k + 32] == 0) {
                    valid = 0;
                    break;
                }
                if (seen[k + 32] > 0 && seen[k] == 0) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                maxLength = fmax(maxLength, j - i);
            }
        }
    }
    return maxLength;
}