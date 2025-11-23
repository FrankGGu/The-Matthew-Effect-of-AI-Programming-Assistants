char* customSortString(char* order, char* s) {
    int count[26] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i] - 'a']++;
    }

    char* result = (char*)malloc(strlen(s) + 1);
    int idx = 0;

    for (int i = 0; order[i]; i++) {
        while (count[order[i] - 'a'] > 0) {
            result[idx++] = order[i];
            count[order[i] - 'a']--;
        }
    }

    for (char c = 'a'; c <= 'z'; c++) {
        while (count[c - 'a'] > 0) {
            result[idx++] = c;
            count[c - 'a']--;
        }
    }

    result[idx] = '\0';
    return result;
}