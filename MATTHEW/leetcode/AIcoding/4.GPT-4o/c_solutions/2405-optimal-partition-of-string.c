int partitionString(char * s) {
    int count = 0;
    int charMap[26] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        if (charMap[s[i] - 'a'] == 0) {
            charMap[s[i] - 'a']++;
        } else {
            count++;
            memset(charMap, 0, sizeof(charMap));
            charMap[s[i] - 'a']++;
        }
    }

    return count + 1;
}