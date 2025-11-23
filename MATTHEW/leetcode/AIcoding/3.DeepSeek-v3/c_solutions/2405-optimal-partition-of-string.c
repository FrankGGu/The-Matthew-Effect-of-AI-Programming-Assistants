int partitionString(char* s) {
    int seen[26] = {0};
    int count = 1;

    for (int i = 0; s[i] != '\0'; i++) {
        if (seen[s[i] - 'a']) {
            count++;
            for (int j = 0; j < 26; j++) {
                seen[j] = 0;
            }
        }
        seen[s[i] - 'a'] = 1;
    }

    return count;
}