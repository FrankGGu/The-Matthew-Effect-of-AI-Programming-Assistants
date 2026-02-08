char * shiftingLetters(char * s, int** shifts, int shiftsSize, int* shiftsColSize){
    int n = strlen(s);
    long long *shift = (long long *)calloc(n + 1, sizeof(long long));
    for (int i = 0; i < shiftsSize; i++) {
        int start = shifts[i][0], end = shifts[i][1], direction = shifts[i][2];
        shift[start] += (direction == 1 ? 1 : -1);
        shift[end + 1] -= (direction == 1 ? 1 : -1);
    }
    long long totalShift = 0;
    for (int i = 0; i < n; i++) {
        totalShift += shift[i];
        s[i] = 'a' + (s[i] - 'a' + totalShift + 26) % 26;
    }
    free(shift);
    return s;
}