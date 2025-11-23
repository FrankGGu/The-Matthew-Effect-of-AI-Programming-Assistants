char * shiftingLetters(char * s, int* shifts, int shiftsSize){
    long long current_shift = 0;

    for (int i = shiftsSize - 1; i >= 0; i--) {
        current_shift = (current_shift + shifts[i]) % 26;
        s[i] = (char)(((s[i] - 'a' + current_shift) % 26) + 'a');
    }

    return s;
}