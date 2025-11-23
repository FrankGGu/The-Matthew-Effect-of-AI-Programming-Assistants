bool queryString(char* s, int n) {
    for (int i = 1; i <= n; i++) {
        char buffer[32];
        int num = i;
        int idx = 0;

        while (num > 0) {
            buffer[idx++] = (num & 1) + '0';
            num >>= 1;
        }
        buffer[idx] = '\0';

        for (int j = 0; j < idx / 2; j++) {
            char temp = buffer[j];
            buffer[j] = buffer[idx - 1 - j];
            buffer[idx - 1 - j] = temp;
        }

        if (strstr(s, buffer) == NULL) {
            return false;
        }
    }
    return true;
}