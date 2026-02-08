int passThePillow(int n, int time) {
    int cycles = time / (n - 1);
    int remainder = time % (n - 1);

    if (cycles % 2 == 0) {
        return remainder + 1;
    } else {
        return n - remainder;
    }
}