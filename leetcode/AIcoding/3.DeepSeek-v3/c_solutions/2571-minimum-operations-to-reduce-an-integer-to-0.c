int minOperations(int n) {
    int operations = 0;
    while (n > 0) {
        if ((n & 1) == 0) {
            n >>= 1;
        } else if ((n & 3) == 3) {
            n++;
            operations++;
        } else {
            n >>= 1;
            operations++;
        }
    }
    return operations;
}