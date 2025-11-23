char *toGoatLatin(char *S) {
    int len = strlen(S);
    char *result = malloc(len * 3); // Max size for goat latin
    char *word = strtok(S, " ");
    char *ptr = result;
    int index = 1;

    while (word != NULL) {
        if (strchr("aeiouAEIOU", word[0])) {
            ptr += sprintf(ptr, "%sma", word);
        } else {
            ptr += sprintf(ptr, "%s%cma", word + 1, word[0]);
        }
        for (int i = 0; i < index; i++) {
            *ptr++ = 'a';
        }
        *ptr++ = ' ';
        word = strtok(NULL, " ");
        index++;
    }

    if (ptr != result) ptr--; // Remove last space
    *ptr = '\0';
    return result;
}