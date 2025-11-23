int countSubstrings(char *s, char *t) {
    int s_len = strlen(s), t_len = strlen(t);
    int count = 0;

    for (int i = 0; i < s_len; i++) {
        for (int j = 0; j < t_len; j++) {
            int diff = 0;
            for (int k = 0; k < s_len; k++) {
                if (s[k] == s[i]) diff++;
            }
            for (int k = 0; k < t_len; k++) {
                if (t[k] == t[j]) diff--;
            }
            if (diff == 0) count++;
        }
    }

    return count;
}