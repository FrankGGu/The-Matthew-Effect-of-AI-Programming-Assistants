int firstUniqChar(char* s) {
    int count[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < len; i++) {
        if (count[s[i] - 'a'] == 1) {
            return i;
        }
    }

    return -1;
}