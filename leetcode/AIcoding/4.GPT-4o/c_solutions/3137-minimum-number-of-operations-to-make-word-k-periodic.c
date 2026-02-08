int minOperations(char *s, int k) {
    int n = strlen(s);
    int minOps = 0;

    for (int i = 0; i < k; i++) {
        int count[26] = {0};
        int maxFreq = 0;

        for (int j = i; j < n; j += k) {
            count[s[j] - 'a']++;
            if (count[s[j] - 'a'] > maxFreq) {
                maxFreq = count[s[j] - 'a'];
            }
        }

        minOps += (n / k) - maxFreq;
    }

    return minOps;
}