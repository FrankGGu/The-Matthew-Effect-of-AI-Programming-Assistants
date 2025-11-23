int maxLength(char * s) {
    int max_len = 0;
    int n = strlen(s);

    for (char a = 'a'; a <= 'z'; a++) {
        for (char b = 'a'; b <= 'z'; b++) {
            if (a == b) continue;
            int count = 0, first = -1, second = -1;
            for (int i = 0; i < n; i++) {
                if (s[i] == a) {
                    count++;
                    if (first == -1) first = i;
                } else if (s[i] == b) {
                    count++;
                    if (second == -1) second = i;
                }
                if (count > 2) break;
                if (count == 2) {
                    max_len = fmax(max_len, i - fmin(first, second) + 1);
                }
            }
        }
    }

    return max_len;
}