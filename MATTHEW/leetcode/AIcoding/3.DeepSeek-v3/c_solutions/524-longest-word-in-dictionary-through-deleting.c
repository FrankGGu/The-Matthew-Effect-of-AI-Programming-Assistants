int compare(const void *a, const void *b) {
    char *s1 = *(char **)a;
    char *s2 = *(char **)b;
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    if (len1 != len2) return len2 - len1;
    return strcmp(s1, s2);
}

char* findLongestWord(char* s, char** dictionary, int dictionarySize) {
    qsort(dictionary, dictionarySize, sizeof(char *), compare);

    for (int i = 0; i < dictionarySize; i++) {
        char *word = dictionary[i];
        int j = 0, k = 0;
        while (s[j] && word[k]) {
            if (s[j] == word[k]) k++;
            j++;
        }
        if (word[k] == '\0') return word;
    }

    return "";
}