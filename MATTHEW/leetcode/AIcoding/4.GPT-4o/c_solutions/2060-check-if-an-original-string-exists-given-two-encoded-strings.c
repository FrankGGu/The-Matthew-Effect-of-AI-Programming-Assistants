bool checkStringExistence(char *s1, char *s2, char *target) {
    int count[256] = {0};
    for (int i = 0; s1[i]; i++) count[s1[i]]++;
    for (int i = 0; s2[i]; i++) count[s2[i]]++;
    for (int i = 0; target[i]; i++) {
        if (--count[target[i]] < 0) return false;
    }
    return true;
}