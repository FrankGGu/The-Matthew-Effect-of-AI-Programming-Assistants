char* alphabetBoardPath(char* target) {
    int x = 0, y = 0;
    int len = strlen(target);
    char* res = (char*)malloc(1000 * sizeof(char));
    int idx = 0;

    for (int i = 0; i < len; i++) {
        int c = target[i] - 'a';
        int tx = c / 5;
        int ty = c % 5;

        while (y > ty) {
            res[idx++] = 'L';
            y--;
        }
        while (x > tx) {
            res[idx++] = 'U';
            x--;
        }
        while (x < tx) {
            res[idx++] = 'D';
            x++;
        }
        while (y < ty) {
            res[idx++] = 'R';
            y++;
        }

        res[idx++] = '!';
    }

    res[idx] = '\0';
    return res;
}