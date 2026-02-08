int countBinarySubstrings(char * s){
    int n = strlen(s);
    int *groups = (int *)malloc(n * sizeof(int));
    int count = 0, index = 0;

    for (int i = 0; i < n; i++) {
        if (i == 0 || s[i] != s[i - 1]) {
            groups[index++] = 1;
        } else {
            groups[index - 1]++;
        }
    }

    for (int i = 1; i < index; i++) {
        count += (groups[i - 1] < groups[i]) ? groups[i - 1] : groups[i];
    }

    free(groups);
    return count;
}