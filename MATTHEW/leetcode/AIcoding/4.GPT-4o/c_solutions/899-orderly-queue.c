char * orderlyQueue(char * s, int k) {
    int n = strlen(s);
    if (k == 1) {
        char *minStr = strdup(s);
        for (int i = 1; i < n; i++) {
            char *temp = (char *)malloc(n + 1);
            strncpy(temp, s + i, n - i);
            strncpy(temp + n - i, s, i);
            temp[n] = '\0';
            if (strcmp(temp, minStr) < 0) {
                free(minStr);
                minStr = temp;
            } else {
                free(temp);
            }
        }
        return minStr;
    } else {
        char *sortedStr = strdup(s);
        qsort(sortedStr, n, sizeof(char), cmp);
        return sortedStr;
    }
}

int cmp(const void *a, const void *b) {
    return (*(char *)a - *(char *)b);
}