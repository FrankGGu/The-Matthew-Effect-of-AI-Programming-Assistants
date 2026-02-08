char* reverseStr(char* s, int k) {
    int len = strlen(s);
    for (int start = 0; start < len; start += 2 * k) {
        int end = start + k - 1;
        if (end >= len) end = len - 1;
        for (int i = start, j = end; i < j; i++, j--) {
            char temp = s[i];
            s[i] = s[j];
            s[j] = temp;
        }
    }
    return s;
}