int countSubstrings(char * s) {
    int len = strlen(s);
    int count = 0;
    int start, end;

    for (int center = 0; center < 2 * len - 1; center++) {
        start = center / 2;
        end = start + center % 2;
        while (start >= 0 && end < len && s[start] == s[end]) {
            count++;
            start--;
            end++;
        }
    }

    return count;
}