int countBinarySubstrings(char * s) {
    int n = strlen(s);
    int *group = malloc(n * sizeof(int));
    int count = 0, index = 0;

    for (int i = 0; i < n; i++) {
        if (i == 0 || s[i] != s[i - 1]) {
            group[index++] = 1;
        } else {
            group[index - 1]++;
        }
    }

    for (int i = 1; i < index; i++) {
        count += fmin(group[i], group[i - 1]);
    }

    free(group);
    return count;
}