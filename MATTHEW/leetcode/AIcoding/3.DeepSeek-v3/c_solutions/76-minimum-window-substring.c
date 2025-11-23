char* minWindow(char* s, char* t) {
    int need[128] = {0};
    int have[128] = {0};
    int t_len = strlen(t);
    int s_len = strlen(s);

    for (int i = 0; i < t_len; i++) {
        need[t[i]]++;
    }

    int min_start = 0, min_len = INT_MAX;
    int start = 0, end = 0;
    int count = 0;

    while (end < s_len) {
        char c = s[end];
        if (need[c] == 0) {
            end++;
            continue;
        }

        have[c]++;
        if (have[c] <= need[c]) {
            count++;
        }

        while (count == t_len) {
            if (end - start + 1 < min_len) {
                min_start = start;
                min_len = end - start + 1;
            }

            char start_char = s[start];
            if (need[start_char] > 0) {
                have[start_char]--;
                if (have[start_char] < need[start_char]) {
                    count--;
                }
            }
            start++;
        }
        end++;
    }

    if (min_len == INT_MAX) {
        return "";
    }

    char* result = (char*)malloc(min_len + 1);
    strncpy(result, s + min_start, min_len);
    result[min_len] = '\0';
    return result;
}