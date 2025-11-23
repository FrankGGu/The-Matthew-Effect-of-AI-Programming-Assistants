int maxDistance(char* s, int k) {
    int count[26] = {0};
    int maxCount = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
        if (count[s[i] - 'a'] > maxCount) {
            maxCount = count[s[i] - 'a'];
        }
    }

    if (maxCount + k >= n) {
        return n;
    } else {
        return maxCount + k;
    }
}