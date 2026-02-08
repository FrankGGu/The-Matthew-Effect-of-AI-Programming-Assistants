bool wordPattern(char * pattern, char * s) {
    char map1[26] = {0}, map2[1000] = {0};
    char *word = strtok(s, " ");
    int i = 0;

    while (word) {
        if (i >= strlen(pattern)) return false;
        if (map1[pattern[i] - 'a'] == 0 && map2[word[0]] == 0) {
            map1[pattern[i] - 'a'] = word[0];
            map2[word[0]] = pattern[i];
        } else if (map1[pattern[i] - 'a'] != word[0] || map2[word[0]] != pattern[i]) {
            return false;
        }
        word = strtok(NULL, " ");
        i++;
    }

    return i == strlen(pattern);
}