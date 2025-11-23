char* strWithout3a3b(int a, int b) {
    char* res = malloc((a + b + 1) * sizeof(char));
    int idx = 0;

    while (a > 0 || b > 0) {
        if (a > b) {
            if (idx >= 2 && res[idx - 1] == 'a' && res[idx - 2] == 'a') {
                res[idx++] = 'b';
                b--;
            } else {
                res[idx++] = 'a';
                a--;
            }
        } else if (b > a) {
            if (idx >= 2 && res[idx - 1] == 'b' && res[idx - 2] == 'b') {
                res[idx++] = 'a';
                a--;
            } else {
                res[idx++] = 'b';
                b--;
            }
        } else {
            if (idx > 0 && res[idx - 1] == 'a') {
                res[idx++] = 'b';
                b--;
            } else {
                res[idx++] = 'a';
                a--;
            }
        }
    }

    res[idx] = '\0';
    return res;
}