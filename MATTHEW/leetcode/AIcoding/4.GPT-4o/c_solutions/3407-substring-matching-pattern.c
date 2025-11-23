bool wordPattern(char * pattern, char * s) {
    char mapP[26] = {0}, mapS[1000] = {0};
    char *word = strtok(s, " ");
    int i = 0;

    while (word) {
        if (i >= strlen(pattern)) return false;
        if (mapP[pattern[i] - 'a'] == 0 && mapS[word[0]] == 0) {
            mapP[pattern[i] - 'a'] = word[0];
            mapS[word[0]] = pattern[i];
        } else if (mapP[pattern[i] - 'a'] != word[0] || mapS[word[0]] != pattern[i]) {
            return false;
        }
        word = strtok(NULL, " ");
        i++;
    }
    return i == strlen(pattern);
}