long long countSubstrings(char* s, char c) {
    long long count = 0;
    long long total = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == c) {
            count++;
            total += count;
        }
    }

    return total;
}