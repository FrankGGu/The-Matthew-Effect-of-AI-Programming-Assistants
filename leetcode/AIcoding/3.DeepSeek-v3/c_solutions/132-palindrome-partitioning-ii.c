int minCut(char* s) {
    int n = strlen(s);
    if (n <= 1) return 0;

    int* cut = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        cut[i] = i - 1;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; i - j >= 0 && i + j < n && s[i - j] == s[i + j]; j++) {
            if (cut[i + j + 1] > cut[i - j] + 1) {
                cut[i + j + 1] = cut[i - j] + 1;
            }
        }

        for (int j = 1; i - j + 1 >= 0 && i + j < n && s[i - j + 1] == s[i + j]; j++) {
            if (cut[i + j + 1] > cut[i - j + 1] + 1) {
                cut[i + j + 1] = cut[i - j + 1] + 1;
            }
        }
    }

    int result = cut[n];
    free(cut);
    return result;
}