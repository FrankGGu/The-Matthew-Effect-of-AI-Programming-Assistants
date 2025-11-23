int numberOfSubstrings(char* s) {
    int n = strlen(s);
    long long total = (long long)n * (n + 1) / 2;
    long long count = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            int j = i;
            while (j < n && s[j] == '0') {
                j++;
            }
            int zeros = j - i;
            count += (long long)zeros * (zeros + 1) / 2;
            i = j - 1;
        }
    }

    return total - count;
}