char * shiftingLetters(char * s, int* shifts, int shiftsSize) {
    long totalShift = 0;
    for (int i = shiftsSize - 1; i >= 0; i--) {
        totalShift = (totalShift + shifts[i]) % 26;
        s[i] = 'a' + (s[i] - 'a' + totalShift) % 26;
    }
    return s;
}