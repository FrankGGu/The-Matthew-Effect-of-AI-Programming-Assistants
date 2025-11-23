int countBinarySubstrings(char* s) {
    int prev = 0, curr = 1, count = 0;
    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i-1]) {
            curr++;
        } else {
            prev = curr;
            curr = 1;
        }
        if (prev >= curr) {
            count++;
        }
    }
    return count;
}