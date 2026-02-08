char* decodeAtIndex(char* s, int k) {
    long long size = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (isdigit(s[i])) {
            size *= (s[i] - '0');
        } else {
            size++;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        k %= size;

        if (k == 0 && isalpha(s[i])) {
            char* result = (char*)malloc(2 * sizeof(char));
            result[0] = s[i];
            result[1] = '\0';
            return result;
        }

        if (isdigit(s[i])) {
            size /= (s[i] - '0');
        } else {
            size--;
        }
    }

    return "";
}