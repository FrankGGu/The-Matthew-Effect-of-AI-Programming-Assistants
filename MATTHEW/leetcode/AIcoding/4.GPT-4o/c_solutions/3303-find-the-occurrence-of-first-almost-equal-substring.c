int findFirstAlmostEqualSubstring(char *s, char *t) {
    int len_s = strlen(s);
    int len_t = strlen(t);
    int count = 0;
    for (int i = 0; i < len_s; i++) {
        if (count >= len_t) break;
        if (s[i] == t[count]) {
            count++;
        }
    }
    return (count == len_t) ? 1 : 0;
}