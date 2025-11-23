int cmp(const void *a, const void *b) {
    char *s1 = *(char **)a;
    char *s2 = *(char **)b;
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    if (len1 != len2) return len2 - len1;
    return strcmp(s1, s2);
}

bool isSubsequence(char *s, char *t) {
    while (*t) {
        if (*s == *t) s++;
        t++;
    }
    return !*s;
}

int findLUSlength(char **strs, int strsSize) {
    qsort(strs, strsSize, sizeof(char *), cmp);

    for (int i = 0; i < strsSize; i++) {
        int flag = 1;
        for (int j = 0; j < strsSize; j++) {
            if (i == j) continue;
            if (isSubsequence(strs[i], strs[j])) {
                flag = 0;
                break;
            }
        }
        if (flag) return strlen(strs[i]);
    }

    return -1;
}