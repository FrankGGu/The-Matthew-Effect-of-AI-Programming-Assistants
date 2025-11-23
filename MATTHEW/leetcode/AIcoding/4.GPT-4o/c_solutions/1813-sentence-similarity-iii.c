bool areSentencesSimilar(char *sentence1, char *sentence2) {
    char *token1 = strtok(sentence1, " ");
    char *token2 = strtok(sentence2, " ");
    int len1 = 0, len2 = 0;

    while (token1) {
        len1++;
        token1 = strtok(NULL, " ");
    }

    while (token2) {
        len2++;
        token2 = strtok(NULL, " ");
    }

    if (len1 > len2) {
        char *temp = sentence1;
        sentence1 = sentence2;
        sentence2 = temp;
        int t = len1;
        len1 = len2;
        len2 = t;
    }

    if (len1 == len2) {
        return strcmp(sentence1, sentence2) == 0;
    }

    char *start1 = sentence1;
    char *start2 = sentence2;

    while (*start1 == ' ') start1++;
    while (*start2 == ' ') start2++;

    while (len1 > 0 && len2 > 0 && *start1 == *start2) {
        while (*start1 != ' ' && *start1 != '\0') start1++;
        while (*start2 != ' ' && *start2 != '\0') start2++;

        while (*start1 == ' ') start1++;
        while (*start2 == ' ') start2++;

        len1--;
        len2--;
    }

    return len1 == 0 || len2 == 0;
}