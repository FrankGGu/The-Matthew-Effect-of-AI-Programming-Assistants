int maxLengthBetweenEqualCharacters(char * s) {
    int first[26];
    memset(first, -1, sizeof(first));
    int maxLength = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (first[index] == -1) {
            first[index] = i;
        } else {
            maxLength = fmax(maxLength, i - first[index] - 1);
        }
    }

    return maxLength;
}