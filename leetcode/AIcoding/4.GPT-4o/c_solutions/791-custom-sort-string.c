char * customSortString(char * order, char * s){
    int count[26] = {0};
    int len = strlen(s);
    char *result = malloc(len + 1);
    int index = 0;

    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; order[i] != '\0'; i++) {
        while (count[order[i] - 'a'] > 0) {
            result[index++] = order[i];
            count[order[i] - 'a']--;
        }
    }

    for (int i = 0; i < 26; i++) {
        while (count[i] > 0) {
            result[index++] = 'a' + i;
            count[i]--;
        }
    }

    result[index] = '\0';
    return result;
}