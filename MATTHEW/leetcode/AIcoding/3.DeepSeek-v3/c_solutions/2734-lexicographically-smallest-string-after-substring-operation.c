char* smallestString(char* s) {
    int n = strlen(s);
    int i = 0;

    while (i < n && s[i] == 'a') {
        i++;
    }

    if (i == n) {
        s[n - 1] = 'z';
        return s;
    }

    while (i < n && s[i] != 'a') {
        s[i] = s[i] - 1;
        i++;
    }

    return s;
}