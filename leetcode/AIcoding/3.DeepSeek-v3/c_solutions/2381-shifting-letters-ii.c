char* shiftingLetters(char* s, int** shifts, int shiftsSize, int* shiftsColSize) {
    int n = strlen(s);
    int* diff = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < shiftsSize; i++) {
        int start = shifts[i][0];
        int end = shifts[i][1];
        int direction = shifts[i][2];
        int delta = direction == 1 ? 1 : -1;

        diff[start] += delta;
        if (end + 1 < n) {
            diff[end + 1] -= delta;
        }
    }

    int shift = 0;
    for (int i = 0; i < n; i++) {
        shift = (shift + diff[i]) % 26;
        if (shift < 0) shift += 26;

        int newChar = (s[i] - 'a' + shift) % 26;
        if (newChar < 0) newChar += 26;
        s[i] = 'a' + newChar;
    }

    free(diff);
    return s;
}