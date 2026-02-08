char* shiftingLetters(char* s, int* shifts, int shiftsSize) {
    long long total = 0;
    for (int i = shiftsSize - 1; i >= 0; i--) {
        total += shifts[i];
        int shift = total % 26;
        s[i] = 'a' + (s[i] - 'a' + shift) % 26;
    }
    return s;
}