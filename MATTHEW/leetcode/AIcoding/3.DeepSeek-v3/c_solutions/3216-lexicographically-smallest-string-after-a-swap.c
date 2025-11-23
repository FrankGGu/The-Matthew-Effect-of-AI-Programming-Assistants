char* smallestString(char* s) {
    int n = strlen(s);
    int i = 0;

    while (i < n - 1) {
        if (s[i] > s[i + 1]) {
            char temp = s[i];
            s[i] = s[i + 1];
            s[i + 1] = temp;
            break;
        }
        i++;
    }

    return s;
}