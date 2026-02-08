char *sortVowels(char *s) {
    int n = strlen(s);
    char *vowels = malloc(n + 1);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' || 
            s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U') {
            vowels[count++] = s[i];
        }
    }

    qsort(vowels, count, sizeof(char), (int(*)(const void*, const void*))strcmp);

    char *result = malloc(n + 1);
    int j = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' || 
            s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U') {
            result[i] = vowels[j++];
        } else {
            result[i] = s[i];
        }
    }

    result[n] = '\0';
    free(vowels);
    return result;
}