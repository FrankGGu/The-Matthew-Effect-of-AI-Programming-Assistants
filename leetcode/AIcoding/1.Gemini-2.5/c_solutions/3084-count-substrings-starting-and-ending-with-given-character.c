long long countSubstrings(char * s, char c) {
    long long char_count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c) {
            char_count++;
        }
    }
    return char_count * (char_count + 1) / 2;
}