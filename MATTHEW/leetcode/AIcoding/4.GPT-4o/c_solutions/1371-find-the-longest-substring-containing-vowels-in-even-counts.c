int findTheLongestSubstring(char *s) {
    int mask = 0, maxLength = 0;
    int firstOccurrence[32];
    for (int i = 0; i < 32; i++) firstOccurrence[i] = -1;
    firstOccurrence[0] = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        switch (s[i]) {
            case 'a': mask ^= 1 << 0; break;
            case 'e': mask ^= 1 << 1; break;
            case 'i': mask ^= 1 << 2; break;
            case 'o': mask ^= 1 << 3; break;
            case 'u': mask ^= 1 << 4; break;
        }

        if (firstOccurrence[mask] == -1) {
            firstOccurrence[mask] = i + 1;
        } else {
            maxLength = fmax(maxLength, i + 1 - firstOccurrence[mask]);
        }
    }

    return maxLength;
}