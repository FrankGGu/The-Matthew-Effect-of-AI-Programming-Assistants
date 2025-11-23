int maxLengthBetweenEqualCharacters(char* s) {
    int firstOccurrence[26];
    for (int i = 0; i < 26; i++) {
        firstOccurrence[i] = -1;
    }

    int maxLength = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (firstOccurrence[index] == -1) {
            firstOccurrence[index] = i;
        } else {
            int length = i - firstOccurrence[index] - 1;
            if (length > maxLength) {
                maxLength = length;
            }
        }
    }

    return maxLength;
}