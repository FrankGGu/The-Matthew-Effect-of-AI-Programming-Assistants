int numSplits(char * s) {
    int left[26] = {0}, right[26] = {0};
    int uniqueLeft = 0, uniqueRight = 0, count = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (right[s[i] - 'a'] == 0) uniqueRight++;
        right[s[i] - 'a']++;
    }

    for (int i = 0; s[i] != '\0'; i++) {
        if (left[s[i] - 'a'] == 0) uniqueLeft++;
        left[s[i] - 'a']++;
        right[s[i] - 'a']--;

        if (right[s[i] - 'a'] == 0) uniqueRight--;

        if (uniqueLeft == uniqueRight) count++;
    }

    return count;
}