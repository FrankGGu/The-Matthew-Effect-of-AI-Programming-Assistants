int countSubstrings(char * s, char * t) {
    int s_len = strlen(s), t_len = strlen(t);
    int result = 0;

    for (int i = 0; i < s_len; i++) {
        for (int j = 0; j < t_len; j++) {
            int count_s[26] = {0}, count_t[26] = {0};
            int diff = 0;

            for (int k = 0; k < s_len || k < t_len; k++) {
                if (i + k < s_len) {
                    count_s[s[i + k] - 'a']++;
                }
                if (j + k < t_len) {
                    count_t[t[j + k] - 'a']++;
                }

                if (k < s_len) {
                    if (count_s[s[i + k] - 'a'] == count_t[s[i + k] - 'a'] + 1) diff++;
                    else if (count_s[s[i + k] - 'a'] == count_t[s[i + k] - 'a']) diff--;
                }

                if (k < t_len) {
                    if (count_t[t[j + k] - 'a'] == count_s[t[j + k] - 'a'] + 1) diff++;
                    else if (count_t[t[j + k] - 'a'] == count_s[t[j + k] - 'a']) diff--;
                }

                if (diff == 0) {
                    result++;
                }
            }
        }
    }
    return result;
}