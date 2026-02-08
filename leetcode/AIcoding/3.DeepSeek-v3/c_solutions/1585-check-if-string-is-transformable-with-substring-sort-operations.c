bool isTransformable(char* s, char* t) {
    int n = strlen(s);
    int pos[10][n + 1];
    int len[10] = {0};

    for (int i = 0; i < n; i++) {
        int digit = s[i] - '0';
        pos[digit][len[digit]++] = i;
    }

    int idx[10] = {0};
    for (int i = 0; i < n; i++) {
        int digit = t[i] - '0';
        if (idx[digit] >= len[digit]) {
            return false;
        }

        for (int d = 0; d < digit; d++) {
            if (idx[d] < len[d] && pos[d][idx[d]] < pos[digit][idx[digit]]) {
                return false;
            }
        }

        idx[digit]++;
    }

    return true;
}