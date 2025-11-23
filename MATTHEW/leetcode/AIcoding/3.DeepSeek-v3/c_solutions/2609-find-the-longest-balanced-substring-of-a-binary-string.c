int findTheLongestBalancedSubstring(char* s) {
    int max_len = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            int zeros = 0, ones = 0;
            int j = i;
            while (j < n && s[j] == '0') {
                zeros++;
                j++;
            }
            int k = j;
            while (k < n && s[k] == '1') {
                ones++;
                k++;
            }
            int balanced = 2 * (zeros < ones ? zeros : ones);
            if (balanced > max_len) {
                max_len = balanced;
            }
        }
    }

    return max_len;
}