int flipLights(int n, int presses) {
    if (n == 0) return 0;
    if (presses == 0) return 1;
    if (presses == 1) return n < 4 ? (1 << n) : 4;
    if (presses == 2) return n < 4 ? (1 << (n > 2 ? n : n - 1)) : 4;
    return n < 4 ? (1 << 2) : 4;
}