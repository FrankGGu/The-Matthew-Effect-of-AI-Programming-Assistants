int minimumOperations(int n) {
    int ops = 0;
    while (n > 0) {
        ops++;
        n &= (n - 1);
    }
    return ops;
}