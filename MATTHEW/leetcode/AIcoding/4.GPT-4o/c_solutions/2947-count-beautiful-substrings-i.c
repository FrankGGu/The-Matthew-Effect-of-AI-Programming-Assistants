int countBeautifulSubstrings(char * s, int k) {
    int count = 0;
    int n = strlen(s);
    int freq[26] = {0};

    for (int i = 0; i < n; i++) {
        memset(freq, 0, sizeof(freq));
        int uniqueCount = 0;

        for (int j = i; j < n; j++) {
            if (freq[s[j] - 'a'] == 0) {
                uniqueCount++;
            }
            freq[s[j] - 'a']++;

            if (uniqueCount == k) {
                count++;
            }
            if (uniqueCount > k) {
                break;
            }
        }
    }

    return count;
}