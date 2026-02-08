int strStr(char * haystack, char * needle) {
    int len_h = strlen(haystack);
    int len_n = strlen(needle);

    if (len_n == 0) return 0;
    if (len_h < len_n) return -1;

    for (int i = 0; i <= len_h - len_n; i++) {
        if (strncmp(&haystack[i], needle, len_n) == 0) {
            return i;
        }
    }
    return -1;
}