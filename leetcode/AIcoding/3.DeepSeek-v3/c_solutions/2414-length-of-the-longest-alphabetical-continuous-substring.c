int longestContinuousSubstring(char * s){
    int max_len = 1;
    int current_len = 1;
    int n = strlen(s);

    for (int i = 1; i < n; i++) {
        if (s[i] == s[i-1] + 1) {
            current_len++;
            if (current_len > max_len) {
                max_len = current_len;
            }
        } else {
            current_len = 1;
        }
    }

    return max_len;
}