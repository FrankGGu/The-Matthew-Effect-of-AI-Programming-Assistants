int longestPalindrome(char *s) {
    int count[128] = {0};
    for (int i = 0; s[i]; i++) {
        count[s[i]]++;
    }
    int length = 0, odd_found = 0;
    for (int i = 0; i < 128; i++) {
        if (count[i] % 2 == 0) {
            length += count[i];
        } else {
            length += count[i] - 1;
            odd_found = 1;
        }
    }
    return length + odd_found;
}