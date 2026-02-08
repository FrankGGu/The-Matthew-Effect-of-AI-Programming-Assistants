int minimumTime(char* word) {
    int n = strlen(word);
    int lps[n];
    lps[0] = 0;
    int len = 0;
    int i = 1;

    while (i < n) {
        if (word[i] == word[len]) {
            len++;
            lps[i] = len;
            i++;
        } else {
            if (len != 0) {
                len = lps[len - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }

    int period = n - lps[n - 1];
    if (n % period == 0) {
        return (n / period + 1) / 2;
    } else {
        return (n + period - 1) / period;
    }
}