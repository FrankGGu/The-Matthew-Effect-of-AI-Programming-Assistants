bool canConstruct(char *s, int k) {
    int count[26] = {0};
    int oddCount = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            oddCount++;
        }
    }

    return oddCount <= k && k <= strlen(s);
}