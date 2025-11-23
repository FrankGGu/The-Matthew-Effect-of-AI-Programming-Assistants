int longestAwesome(char * s) {
    int n = strlen(s);
    int mask = 0, maxLength = 0;
    int firstOccurrence[1024];
    memset(firstOccurrence, -1, sizeof(firstOccurrence));
    firstOccurrence[0] = 0;

    for (int i = 0; i < n; i++) {
        mask ^= 1 << (s[i] - '0');
        if (firstOccurrence[mask] == -1) {
            firstOccurrence[mask] = i + 1;
        }
        maxLength = fmax(maxLength, i + 1 - firstOccurrence[mask]);

        for (int j = 0; j < 10; j++) {
            int newMask = mask ^ (1 << j);
            if (firstOccurrence[newMask] != -1) {
                maxLength = fmax(maxLength, i + 1 - firstOccurrence[newMask]);
            }
        }
    }
    return maxLength;
}