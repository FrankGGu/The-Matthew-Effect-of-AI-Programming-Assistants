int minDeletionSize(char ** strs, int strsSize) {
    int n = strsSize;
    int m = strlen(strs[0]);
    int res = 0;
    int *sorted = (int *)calloc(n, sizeof(int));

    for (int j = 0; j < m; j++) {
        int *temp = (int *)malloc(n * sizeof(int));
        memcpy(temp, sorted, n * sizeof(int));
        int valid = 1;

        for (int i = 1; i < n; i++) {
            if (!sorted[i] && strs[i][j] < strs[i-1][j]) {
                valid = 0;
                break;
            }
        }

        if (!valid) {
            res++;
        } else {
            for (int i = 1; i < n; i++) {
                if (!sorted[i] && strs[i][j] > strs[i-1][j]) {
                    temp[i] = 1;
                }
            }
            memcpy(sorted, temp, n * sizeof(int));
        }
        free(temp);
    }

    free(sorted);
    return res;
}