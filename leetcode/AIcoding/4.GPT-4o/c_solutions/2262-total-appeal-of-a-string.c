int appealSum(char * s) {
    long long total = 0, last[26] = {0}, n = strlen(s);
    for (int i = 0; i < n; i++) {
        total += (i + 1) - last[s[i] - 'a'];
        last[s[i] - 'a'] = i + 1;
    }
    return total;
}