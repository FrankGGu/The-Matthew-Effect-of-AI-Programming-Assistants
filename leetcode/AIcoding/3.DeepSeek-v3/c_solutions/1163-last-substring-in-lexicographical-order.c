char* lastSubstring(char* s) {
    int n = strlen(s);
    int i = 0, j = 1, k = 0;

    while (j + k < n) {
        if (s[i + k] == s[j + k]) {
            k++;
            continue;
        }

        if (s[i + k] < s[j + k]) {
            i = j;
            j++;
        } else {
            j = j + k + 1;
        }
        k = 0;
    }

    return s + i;
}