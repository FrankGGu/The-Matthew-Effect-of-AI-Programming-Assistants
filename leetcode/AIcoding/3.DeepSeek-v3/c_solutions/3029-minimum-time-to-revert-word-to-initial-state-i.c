int minimumTimeToInitialState(char* word, int k) {
    int n = strlen(word);
    int t = 1;
    while (t * k < n) {
        int valid = 1;
        for (int i = t * k; i < n; i++) {
            if (word[i] != word[i - t * k]) {
                valid = 0;
                break;
            }
        }
        if (valid) return t;
        t++;
    }
    return t;
}