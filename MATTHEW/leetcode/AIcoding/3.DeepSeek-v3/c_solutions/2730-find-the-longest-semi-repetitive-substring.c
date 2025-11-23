int longestSemiRepetitiveSubstring(char * s){
    int n = strlen(s);
    if (n <= 1) return n;

    int left = 0;
    int last_repeat = -1;
    int max_len = 1;

    for (int right = 1; right < n; right++) {
        if (s[right] == s[right - 1]) {
            if (last_repeat != -1) {
                left = last_repeat + 1;
            }
            last_repeat = right - 1;
        }
        max_len = fmax(max_len, right - left + 1);
    }

    return max_len;
}