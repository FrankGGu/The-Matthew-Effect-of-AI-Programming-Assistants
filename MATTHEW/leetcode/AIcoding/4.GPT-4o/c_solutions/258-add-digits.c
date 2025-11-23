int addDigits(int num) {
    return 1 + (num - 1) % 9 * (num != 0);
}