int findMinChar(int start, int k, char* s, int n) {
    for (int c = start; c < k; c++) {
        char ch = 'a' + c;
        if (n >= 1 && s[n - 1] == ch) continue;
        if (n >= 2 && s[n - 2] == ch) continue;
        return c;
    }
    return -1;
}

char* smallestBeautifulString(char* s, int k) {
    int n = strlen(s);
    int i = n - 1;

    while (i >= 0) {
        int curr = s[i] - 'a' + 1;
        int pos = findMinChar(curr, k, s, i);
        if (pos != -1) {
            s[i] = 'a' + pos;
            for (int j = i + 1; j < n; j++) {
                int p = findMinChar(0, k, s, j);
                if (p == -1) return "";
                s[j] = 'a' + p;
            }
            return s;
        }
        i--;
    }

    return "";
}