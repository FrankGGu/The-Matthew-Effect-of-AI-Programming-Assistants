int minOperations(int n) {
    int operations = 0;
    while (n > 0) {
        if ((n & 1) == 0) { // If the least significant bit is 0
            n >>= 1; // Divide by 2 (shift right)
        } else { // If the least significant bit is 1
            if ((n & 3) == 1) { // If n ends in ...01 (n % 4 == 1)
                n -= 1; // Subtract 2^0
                operations++;
            } else { // If n ends in ...11 (n % 4 == 3)
                n += 1; // Add 2^0
                operations++;
            }
        }
    }
    return operations;
}