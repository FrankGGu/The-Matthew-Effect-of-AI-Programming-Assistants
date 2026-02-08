bool isScramble(char *s1, char *s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    if (len1 != len2) return false;

    if (strcmp(s1, s2) == 0) return true;

    int count[26] = {0};
    for (int i = 0; i < len1; i++) {
        count[s1[i] - 'a']++;
        count[s2[i] - 'a']--;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) return false;
    }

    for (int i = 1; i < len1; i++) {
        if (isScramble(s1, s2) || 
            (isScramble(strndup(s1, i), strndup(s2, i)) && isScramble(strndup(s1 + i, len1 - i), strndup(s2 + i, len1 - i)))) {
            return true;
        }
    }

    return false;
}