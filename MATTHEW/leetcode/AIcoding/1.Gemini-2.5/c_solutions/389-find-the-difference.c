char findTheDifference(char *s, char *t) {
    int freq[26] = {0};
    int i = 0;
    while (s[i] != '\0') {
        freq[s[i] - 'a']++;
        i++;
    }
    i = 0;
    while (t[i] != '\0') {
        freq[t[i] - 'a']--;
        if (freq[t[i] - 'a'] < 0) {
            return t[i];
        }
        i++;
    }
    return ' '; // Should not reach here based on problem constraints
}