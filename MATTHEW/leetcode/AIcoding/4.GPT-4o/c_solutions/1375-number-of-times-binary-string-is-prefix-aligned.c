int countBinarySubstrings(char * s) {
    int count = 0, prev = 0, curr = 1, n = strlen(s);

    for (int i = 1; i < n; i++) {
        if (s[i] == s[i - 1]) {
            curr++;
        } else {
            count += (prev < curr) ? prev : curr;
            prev = curr;
            curr = 1;
        }
    }
    count += (prev < curr) ? prev : curr;

    return count;
}