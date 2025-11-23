int countSpecialSubstrings(char * s, int k) {
    int n = strlen(s), count = 0;
    if (n < k) return 0;

    int freq[26] = {0};
    for (int i = 0; i < k; i++) {
        freq[s[i] - 'a']++;
    }

    int uniqueCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) uniqueCount++;
    }

    if (uniqueCount == k) count++;

    for (int i = k; i < n; i++) {
        freq[s[i] - 'a']++;
        freq[s[i - k] - 'a']--;

        if (freq[s[i] - 'a'] == 1) uniqueCount++;
        if (freq[s[i - k] - 'a'] == 0) uniqueCount--;

        if (uniqueCount == k) count++;
    }

    return count;
}